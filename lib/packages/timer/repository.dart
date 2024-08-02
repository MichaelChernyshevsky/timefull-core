// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:timefullcore/core.dart';

class TimerRepository implements TimerInterface {
  final HttpService httpService;
  final Isar isar;

  const TimerRepository({
    required this.httpService,
    required this.isar,
  });

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

  Future<TimerModel?> get model async => isar.timerModels.where().findFirst();

  void get wipeIsar async => isar.writeTxn(() async => await isar.timerModels.where().deleteAll());

  Future put(TimerModel model) async => isar.writeTxn(() async => isar.timerModels.put(model));

  // @override
  // Future<TimerModel> getTimerApi({required String userId}) async {
  //   return TimerModel(id: )
  // }
}
