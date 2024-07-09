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

  bool stateIsWork = false;
  int twForm = 0 * 60;
  int trForm = 0 * 60;

  TimerState timerState = TimerState.stop;
  Timer? timer;
  late Isar _isar;

  CollectionSchema get shemaTimer => TimerModelSchema;

  StreamController<Connector> timeModel = StreamController<Connector>.broadcast();

  // // timeModel.stream.listen((event){

  // // });

  Stream<Connector> get stream async* {
    final m = await model;
    trForm = m.timeRelaxSave * 60;
    twForm = m.timeWorkSave * 60;
    yield Connector(title: 'stop', timeRelax: m.timeRelaxSave, timeWork: m.timeWorkSave);
    yield* timeModel.stream;
  }

  void refresh({required String userId}) {}

  Future<void> initialize({required bool internet, required bool loggined, required String userId, required Isar isar}) async {
    _isar = isar;
    if (internet && loggined) refresh(userId: userId);
  }

  Future<void> inisializeStream() async {}

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

  Future<bool> wipe() async => true;

  void change({required bool isWork, required bool isIncrease, required int work, required int relax}) {
    work = work * 60;
    relax = relax * 60;
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
    twForm = work;
    trForm = relax;
    timeModel.add(Connector(title: 'stop', timeRelax: (relax / 60).round(), timeWork: (work / 60).round()));
  }

  Future<void> setTimerForm(int index) async {
    twForm = 0;
    trForm = 0;
    final element = await _isar.timerModels.where().findFirst();
    await _isar.writeTxn(() async => await _isar.timerModels.where().deleteAll());

    if (index == 1) {
      twForm = 30;
      trForm = 10;
    } else if (index == 2) {
      twForm = 20;
      trForm = 5;
    } else {
      twForm = 10;
      trForm = 2;
    }
    element!.timeRelaxSave = trForm;
    element.timeWorkSave = twForm;
    twForm *= 60;
    twForm *= 60;

    await _isar.writeTxn(() async => await _isar.timerModels.put(element));
    timeModel.add(
      Connector(
        title: 'stop',
        timeRelax: (trForm / 60).round(),
        timeWork: (twForm / 60).round(),
      ),
    );
  }

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

  Future<TimerModel> get model async {
    final m = await _isar.timerModels.where().findFirst();
    if (m != null) {
      return m;
    }
    await _isar.writeTxn(() async => await _isar.timerModels.put(TimerModel(id: 1, userId: '0', timeRelax: 0, timeWork: 0, work: 0, relax: 0)));
    return await model;
  }

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

  Duration get duration => const Duration(seconds: 1);

  void action({required String userId, required bool loggined, required bool internet}) {
    int timeWork = twForm;
    int timeRelax = trForm;

    void timerHandler() {
      Timer workTimer() => Timer.periodic(duration, (_) {
            if (timeWork > 0) {
              timeWork -= 1;
              timeModel.add(Connector(title: getNumber(timeWork), timeRelax: (trForm / 60).round(), timeWork: (twForm / 60).round()));
            } else {
              timeWork = twForm;
              timerState = TimerState.relax;
              addTimeWork(time: twForm ~/ 60, userId: userId, loggined: loggined, internet: internet);

              timerHandler();
            }
            notifyListeners();
          });
      Timer relaxTimer() => Timer.periodic(
            duration,
            (_) {
              if (timeRelax > 0) {
                timeRelax -= 1;
                timeModel.add(Connector(title: getNumber(timeRelax), timeRelax: (trForm / 60).round(), timeWork: (twForm / 60).round()));
              } else {
                timeRelax = trForm;
                timerState = TimerState.work;
                addTimeRelax(time: trForm ~/ 60, userId: userId, loggined: loggined, internet: internet);
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

    if (stateIsWork == false) {
      stateIsWork = true;
      timeWork = twForm;
      timeRelax = trForm;
      changeHistory(work: twForm, relax: trForm, userId: userId, loggined: loggined, internet: internet);
      timerState = TimerState.work;
      timerHandler();
    } else {
      stateIsWork = false;
      timerState = TimerState.stop;
      timeModel.add(Connector(title: 'stop', timeRelax: (trForm / 60).round(), timeWork: (twForm / 60).round()));
      timer?.cancel();
    }
  }
}
