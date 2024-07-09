import 'package:timefullcore/packages/tasks/model.dart';

abstract class TaskInterface {
  void getTasks({
    required bool internet,
    required bool loggined,
    required String userId,
  }) =>
      TasksModels([]);
  void deleteTask({
    required int id,
    required bool internet,
    required bool loggined,
    required String userId,
  }) {}
  void editTask({
    required TaskModel model,
    required bool internet,
    required bool loggined,
    required String userId,
  }) {}
  void wipeTask({
    required bool internet,
    required bool loggined,
    required String userId,
  }) {}

  void addTask({
    required TaskModel model,
    required bool internet,
    required bool loggined,
    required String userId,
  }) {}

  void getTasksApi({required String userId}) {}
  void deleteTasksApi({required String taskId}) {}
  void editTasksApi({
    required String taskId,
    required String title,
    required String description,
    required String date,
    required String countOnDay,
    required String countOnTask,
  }) {}
  void addTasksApi({
    required String userId,
    required String title,
    required String description,
    required String date,
    required String countOnDay,
    required String countOnTask,
  }) {}
  void statEditTasksApi({required String userId, required String countDone, required String countUnDone}) {}
}
