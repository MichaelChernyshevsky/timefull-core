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
  final TimerModel model;

  Connector({
    required this.title,
    required this.timeRelax,
    required this.timeWork,
    required this.model,
  });
}

class TimerService extends ChangeNotifier implements Repository {
  TimerService({required this.httpService});

  @override
  final HttpService httpService;
  late TimerRepository repository;

  bool stateIsWork = false;
  int twForm = 0 * 60;
  int trForm = 0 * 60;

  TimerState timerState = TimerState.stop;
  Timer? timer;

  CollectionSchema get shema => TimerModelSchema;

  StreamController<Connector> timeModel = StreamController<Connector>.broadcast();

  Stream<Connector> get stream async* {
    final m = await model;
    trForm = m.timeRelaxSave * 60;
    twForm = m.timeWorkSave * 60;
    yield Connector(title: 'stop', timeRelax: m.timeRelaxSave, timeWork: m.timeWorkSave, model: m);
    yield* timeModel.stream;
  }

  Future<void> initialize({required CoreModel coreModel, required Isar isar}) async {
    if (coreModel.internet && coreModel.loggined) refresh(userId: coreModel.userId);
    repository = TimerRepository(httpService: httpService, isar: isar);
  }

  void importdb(Map<String, dynamic> db) {}

  Map<String, dynamic> exportdb() {
    return {
      'economy': {},
      'sport': {},
      'notes': {},
      'tasks': {},
      'timer': {},
    };
  }

  void refresh({required String userId}) {}

  Future<bool> wipe() async => true;

  Future<void> change({required bool isWork, required bool isIncrease, required int work, required int relax}) async {
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
    timeModel.add(Connector(title: 'stop', timeRelax: (relax / 60).round(), timeWork: (work / 60).round(), model: await model));
  }

  Future<void> setTimerForm(int index) async {
    twForm = 0;
    trForm = 0;
    final element = await repository.model;
    repository.wipeIsar;

    if (index == 1) {
      twForm = 30;
      trForm = 10;
    } else if (index == 2) {
      twForm = 20;
      trForm = 5;
    } else if (index == 3) {
      twForm = 10;
      trForm = 2;
    } else if (index == 0) {
      twForm = 0;
      trForm = 0;
    }
    element!.timeRelaxSave = trForm;
    element.timeWorkSave = twForm;
    twForm *= 60;
    twForm *= 60;

    await repository.put(element);
    timeModel.add(
      Connector(
        title: 'stop',
        timeRelax: (trForm / 60).round(),
        timeWork: (twForm / 60).round(),
        model: await model,
      ),
    );
  }

  Future<TimerModel> getTimerIsar({required String userId}) async {
    final BaseResponse resp = await httpService.post(timerGet, data: {"userId": userId});
    final model = TimerModel.fromJson(json: resp.data);
    await repository.put(model);

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
      final element = await repository.model;
      repository.wipeIsar;
      if (loggined && internet) {
        // final resp = await editTimerHistoryApi(
        //   relax: (element!.relaxSave + int.parse(relax)).toString(),
        //   work: (element.workSave + int.parse(work)).toString(),
        //   userId: userId,
        // );
        // if (resp) {
        //   element.relaxSave = 0;
        //   element.workSave = 0;
        // }
        // await _isar.writeTxn(() async => await _isar.timerModels.put(element));
        return RepositoryStat.sended;
      } else {
        element!.timeWorkSave = (int.parse(work) / 60).round();
        element.timeRelaxSave = (int.parse(relax) / 60).round();
      }
      repository.put(element);
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
        // element.timeWorkSave += int.parse(timeWork);
        // element.timeRelaxSave += int.parse(timeRelax);
        element.workSave += int.parse(timeWork);
        element.relaxSave += int.parse(timeRelax);
        await repository.put(element);

        return RepositoryStat.saved;
      }

      final element = repository.model;
      repository.wipeIsar;

      if (loggined && internet) {
        // final resp = await editTimerStatApi(
        //   userId: userId,
        //   timeWork: (element!.timeWorkSave + int.parse(timeWork)).toString(),
        //   timeRelax: (element.timeRelaxSave + int.parse(timeRelax)).toString(),
        // );
        // if (resp == true) {
        //   element.timeWorkSave = 0;
        //   element.timeRelaxSave = 0;
        //   await _isar.writeTxn(() async => await _isar.timerModels.put(element));
        //   return RepositoryStat.sended;
        // }
      }
      return await save(element);
    } catch (_) {
      return RepositoryStat.error;
    }
  }

  Future<TimerModel> get model async {
    final m = await repository.model;
    if (m != null) {
      return m;
    }
    await repository.put(TimerModel(id: 1, userId: '0', timeRelax: 0, timeWork: 0, work: 0, relax: 0));
    return await model;
  }

  Duration get duration => const Duration(seconds: 1);

  Future<void> action({required String userId, required bool loggined, required bool internet}) async {
    int timeWork = twForm;
    int timeRelax = trForm;

    void timerHandler() {
      Timer workTimer() => Timer.periodic(duration, (_) async {
            if (timeWork > 0) {
              timeWork -= 1;
              timeModel.add(Connector(title: getNumber(timeWork), timeRelax: (trForm / 60).round(), timeWork: (twForm / 60).round(), model: await model));
            } else {
              timeWork = twForm;
              timerState = TimerState.relax;
              await sendStat(
                timeRelax: '0',
                timeWork: (twForm ~/ 60).toString(),
                userId: userId,
                loggined: loggined,
                internet: internet,
              );
              timerHandler();
            }
            notifyListeners();
          });
      Timer relaxTimer() => Timer.periodic(
            duration,
            (_) async {
              if (timeRelax > 0) {
                timeRelax -= 1;
                timeModel.add(Connector(title: getNumber(timeRelax), timeRelax: (trForm / 60).round(), timeWork: (twForm / 60).round(), model: await model));
              } else {
                timeRelax = trForm;
                timerState = TimerState.work;
                await sendStat(
                  timeWork: '0',
                  timeRelax: (trForm ~/ 60).toString(),
                  userId: userId,
                  loggined: loggined,
                  internet: internet,
                );

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
      sendHistory(
        relax: trForm.toString(),
        work: twForm.toString(),
        userId: userId,
        loggined: loggined,
        internet: internet,
      );
      timerState = TimerState.work;
      timerHandler();
    } else {
      stateIsWork = false;
      timerState = TimerState.stop;
      timeModel.add(Connector(title: 'stop', timeRelax: (trForm / 60).round(), timeWork: (twForm / 60).round(), model: await model));
      timer?.cancel();
    }
  }
}
