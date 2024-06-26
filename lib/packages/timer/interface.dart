abstract class TimerInterface {
  void getTimerApi({required String userId}) {}

  void editTimerHistoryApi({
    required String userId,
    required String work,
    required String relax,
  }) {}

  void editTimerStatApi({
    required String userId,
    required String timeWork,
    required String timeRelax,
  }) {}
}
