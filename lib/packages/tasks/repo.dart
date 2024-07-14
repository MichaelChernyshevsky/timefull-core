part of '../../service.dart';

class TaskRepository extends Repository implements TaskInterface {
  final TaskService taskService;
  late Isar _isar;

  TaskRepository({required super.httpService}) : taskService = TaskService(httpService: httpService);

  CollectionSchema get shemaTask => TaskModelSchema;

  Future<void> initialize({
    required bool internet,
    required bool loggined,
    required String userId,
    required Isar isar,
  }) async {
    _isar = isar;
    if (internet && loggined) await refresh(userId: userId);
  }

  Future<void> refresh({required String userId}) async => await _isar.writeTxn(() async {
        final now = DateTime.now();
        final todayDateMilliseconds = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
        final tasks = await _isar.taskModels.where().findAll();

        int millisecondsToDays(int milliseconds) {
          const int msPerDay = 24 * 60 * 60 * 1000;
          int days = (milliseconds / msPerDay).floor();
          return days;
        }

        for (var task in tasks) {
          if (task.date != todayDateMilliseconds) {
            int counOnTask = task.countOnTask;
            if (counOnTask == task.countOnTaskDone) {
              task.countDoneTotal += counOnTask;
            } else {
              counOnTask -= task.countOnTaskDone;
              task.countDoneTotal += task.countOnTaskDone;
              task.countUnDoneTotal += counOnTask;
            }
            task.countOnTaskDone = 0;
            task.countUnDoneTotal += millisecondsToDays(todayDateMilliseconds - task.date) - 1;
            task.date = todayDateMilliseconds;

            await _isar.taskModels.put(task);
          }
        }
      });

  @override
  Future<void> deleteTask({
    required int id,
    required bool internet,
    required bool loggined,
    required String userId,
  }) async {
    await _isar.writeTxn(() async => await _isar.economyModels.delete(id));
  }

  @override
  Future<void> editTask({
    required TaskModel model,
    required bool internet,
    required bool loggined,
    required String userId,
  }) async {
    await _isar.writeTxn(() async => await _isar.taskModels.put(model));
  }

  @override
  Future<void> addTask({
    required TaskModel model,
    required bool internet,
    required bool loggined,
    required String userId,
  }) async {
    await _isar.writeTxn(() async => _isar.taskModels.put(model));
  }

  @override
  Future<TasksModels> getTasks({
    required bool internet,
    required bool loggined,
    required String userId,
  }) async {
    final tasks = await _isar.taskModels.where().findAll();
    return TasksModels(tasks);
  }

  @override
  Future<void> wipeTask({
    required bool internet,
    required bool loggined,
    required String userId,
  }) async {
    await _isar.writeTxn(() async => await _isar.taskModels.clear());
  }

  // api

  @override
  Future<bool> addTasksApi({
    required String userId,
    required String title,
    required String description,
    required String date,
    required String countOnDay,
    required String countOnTask,
  }) async =>
      taskService.addTaskApi(
        userId: userId,
        title: title,
        description: description,
        date: date,
        countOnDay: countOnDay,
        countOnTask: countOnTask,
      );

  @override
  Future<bool> deleteTasksApi({required String taskId}) async => taskService.deleteTaskApi(taskId: taskId);

  @override
  Future<bool> editTasksApi({
    required String taskId,
    required String title,
    required String description,
    required String date,
    required String countOnDay,
    required String countOnTask,
  }) async =>
      taskService.editTaskApi(
        taskId: taskId,
        title: title,
        description: description,
        date: date,
        countOnDay: countOnDay,
        countOnTask: countOnTask,
      );

  @override
  Future<TasksModels> getTasksApi({required String userId}) async => taskService.getTasksApi(userId: userId);

  @override
  Future<bool> statEditTasksApi({
    required String userId,
    required String countDone,
    required String countUnDone,
  }) async =>
      taskService.statEditTaskApi(
        userId: userId,
        countDone: countDone,
        countUnDone: countUnDone,
      );
}
