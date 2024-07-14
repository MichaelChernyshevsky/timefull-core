import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/tasks/model.dart';

abstract class TaskInterface {
  void getTasks({required CoreModel coreModel}) => TasksModels([]);
  void deleteTask({required int id, required CoreModel coreModel}) {}
  void editTask({required TaskModel model, required CoreModel coreModel}) {}
  void wipeTask({required CoreModel coreModel}) {}

  void addTask({required TaskModel model, required CoreModel coreModel}) {}

  void markTask({required int modelId, required CoreModel coreModel}) {}

  void unMarkTask({required int modelId, required CoreModel coreModel}) {}

  // api

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
