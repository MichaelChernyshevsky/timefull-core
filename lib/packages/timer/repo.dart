part of '../../service.dart';

enum TimerState {
  work,
  stop,
  relax,
}

class Connector {
  final String title;
  final int timeRelax;
  final int timeWork;

  Connector({
    required this.title,
    required this.timeRelax,
    required this.timeWork,
  });
}

class TimerRepository extends ChangeNotifier implements Repository, TimerInterface {
  TimerRepository({required this.httpService});

  @override
  final HttpService httpService;

  StreamController<Connector> timeModel = StreamController<Connector>.broadcast();

  int tw = 0 * 60;
  int tr = 0 * 60;
  int timeWork = 0;
  int timeRelax = 0;
  TimerState timerState = TimerState.stop;
  Timer? timer;
  late Isar _isar;

  CollectionSchema get shemaTimer => TimerModelSchema;

  void refresh({required String userId}) {}

  Future<void> initialize({required bool internet, required bool loggined, required String userId, required Isar isar}) async {
    _isar = isar;
    if (internet && loggined) refresh(userId: userId);
  }

  // String get relax {
  // const String min = 'm';
  // const String hour = 'h';

  // if (relax < 60) {
  //   return '$relax $min';
  // } else {
  //   final hours = relax / 60;
  //   final minutes = relax % 60;
  //   if (minutes == 0) {
  //     return '$hours $hour';
  //   } else {
  //     return '$hours $hour $minutes $min';
  //   }
  // }
  // }

  // String get work {
  //   const String min = 'm';
  //   const String hour = 'h';

  //   final work = stat.work;
  //   if (work < 60) {
  //     return '$work $min';
  //   } else {
  //     final hours = work / 60;
  //     final minutes = work % 60;
  //     if (minutes == 0) {
  //       return '$hours $hour';
  //     } else {
  //       return '$hours $hour $minutes $min';
  //     }
  //   }
  // }

  Future wipe() async {}

  void change({required isWork, required isIncrease, required work, required relax}) {
    work = int.parse(work) * 60;
    relax = int.parse(relax) * 60;
    if (isWork) {
      if (isIncrease) {
        work += 60;
      } else {
        if (work > 0) {
          work -= 60;
        }
      }
    } else {
      if (isIncrease) {
        relax += 60;
      } else {
        if (relax > 0) {
          relax -= 60;
        }
      }
    }
    timeModel.add(Connector(title: 'stop', timeRelax: (relax / 60).round(), timeWork: (work / 60).round()));
  }

  void setTimerForm(int index) {
    tw = 0;
    tr = 0;
    if (index == 1) {
      tw = 30 * 60;
      tr = 10 * 60;
    } else if (index == 2) {
      tw += 20 * 60;
      tr = 5 * 60;
    } else {
      tw += 10 * 60;
      tr = 2 * 60;
    }
    timeModel.add(
      Connector(
        title: 'stop',
        timeRelax: (tr / 60).round(),
        timeWork: (tw / 60).round(),
      ),
    );
  }

  Duration get duration => const Duration(seconds: 1);
  @override
  Future<bool> editTimerHistoryApi({required String userId, required String work, required String relax}) async {
    final BaseResponse resp = await httpService.patch(
      timerEditHistory,
      data: {
        "userId": userId,
        "work": work,
        "relax": relax,
      },
    );
    return resp.message == MESSAGE_SUCCESS;
  }

  @override
  Future<bool> editTimerStatApi({required String userId, required String timeWork, required String timeRelax}) async {
    final BaseResponse resp = await httpService.patch(timerEditStat, data: {
      "userId": userId,
      "timeWork": timeWork,
      "timeRelax": timeRelax,
    });
    return resp.message == MESSAGE_SUCCESS;
  }

  @override
  Future<TimerModel> getTimerApi({required String userId}) async {
    final BaseResponse resp = await httpService.post(timerGet, data: {"userId": userId});
    final model = TimerModel.fromJson(json: resp.data);
    await _isar.writeTxn(() async => await _isar.timerModels.put(model));
    return model;
  }

  Future<RepositoryStat> sendHistory({
    required String userId,
    required String work,
    required String relax,
    required bool loggined,
    required bool internet,
  }) async {
    try {
      final element = await _isar.timerModels.where().findFirst();
      await _isar.writeTxn(() async => await _isar.timerModels.where().deleteAll());
      if (loggined && internet) {
        final resp = await editTimerHistoryApi(
          relax: (element!.relaxSave + int.parse(relax)).toString(),
          work: (element.workSave + int.parse(work)).toString(),
          userId: userId,
        );
        if (resp) {
          element.relaxSave = 0;
          element.workSave = 0;
        }
        await _isar.writeTxn(() async => await _isar.timerModels.put(element));
        return RepositoryStat.sended;
      } else {
        element!.relaxSave += int.parse(work);
        element.workSave += int.parse(relax);
      }
      await _isar.writeTxn(() async => await _isar.timerModels.put(element));
      return RepositoryStat.saved;
    } catch (_) {
      return RepositoryStat.error;
    }
  }

  Future<RepositoryStat> sendStat({
    required String userId,
    required String timeWork,
    required String timeRelax,
    required bool loggined,
    required bool internet,
  }) async {
    try {
      Future<RepositoryStat> save(element) async {
        element.timeWorkSave += int.parse(timeWork);
        element.timeRelaxSave += int.parse(timeRelax);
        await _isar.writeTxn(() async => await _isar.timerModels.put(element));
        return RepositoryStat.saved;
      }

      final element = await _isar.timerModels.where().findFirst();
      await _isar.writeTxn(() async => await _isar.timerModels.where().deleteAll());
      if (loggined && internet) {
        final resp = await editTimerStatApi(
          userId: userId,
          timeWork: (element!.timeWorkSave + int.parse(timeWork)).toString(),
          timeRelax: (element.timeRelaxSave + int.parse(timeRelax)).toString(),
        );
        if (resp == true) {
          element.timeWorkSave = 0;
          element.timeRelaxSave = 0;
          await _isar.writeTxn(() async => await _isar.timerModels.put(element));
          return RepositoryStat.sended;
        }
      }
      return await save(element);
    } catch (_) {
      return RepositoryStat.error;
    }
  }

  Future<TimerModel?> get model async => await _isar.timerModels.where().findFirst();

  Future<RepositoryStat> addTimeWork({
    required int time,
    required String userId,
    required bool loggined,
    required bool internet,
  }) async =>
      await sendStat(
        timeRelax: '0',
        timeWork: time.toString(),
        userId: userId,
        loggined: loggined,
        internet: internet,
      );

  Future<RepositoryStat> addTimeRelax({
    required int time,
    required String userId,
    required bool loggined,
    required bool internet,
  }) async =>
      await sendStat(
        timeRelax: time.toString(),
        timeWork: '0',
        userId: userId,
        loggined: loggined,
        internet: internet,
      );

  Future<RepositoryStat> changeHistory({
    required int work,
    required int relax,
    required String userId,
    required bool loggined,
    required bool internet,
  }) async =>
      await sendHistory(
        relax: relax.toString(),
        work: work.toString(),
        userId: userId,
        loggined: loggined,
        internet: internet,
      );

  void action({required bool start, required String userId, required bool loggined, required bool internet}) {
    void timerHandler() {
      Timer workTimer() => Timer.periodic(duration, (_) {
            if (timeWork > 0) {
              timeWork -= 1;
              timeModel.add(Connector(title: getNumber(timeWork), timeRelax: (tr / 60).round(), timeWork: (tw / 60).round()));
            } else {
              timeWork = tw;
              timerState = TimerState.relax;
              addTimeWork(time: tw ~/ 60, userId: userId, loggined: loggined, internet: internet);

              timerHandler();
            }
            notifyListeners();
          });
      Timer relaxTimer() => Timer.periodic(
            duration,
            (_) {
              if (timeRelax > 0) {
                timeRelax -= 1;
                timeModel.add(Connector(title: getNumber(timeRelax), timeRelax: (tr / 60).round(), timeWork: (tw / 60).round()));
              } else {
                timeRelax = tr;
                timerState = TimerState.work;
                addTimeRelax(time: tr ~/ 60, userId: userId, loggined: loggined, internet: internet);
                timerHandler();
              }
              notifyListeners();
            },
          );

      timer?.cancel();
      if (timerState == TimerState.relax) {
        timer = relaxTimer();
      } else {
        timer = workTimer();
      }
    }

    if (start) {
      timeWork = tw;
      timeRelax = tr;
      changeHistory(work: tw, relax: tr, userId: userId, loggined: loggined, internet: internet);
      timerState = TimerState.work;
      timerHandler();
    } else {
      timerState = TimerState.stop;
      timeModel.add(Connector(title: 'stop', timeRelax: (tr / 60).round(), timeWork: (tw / 60).round()));
      timer?.cancel();
    }
  }
}
