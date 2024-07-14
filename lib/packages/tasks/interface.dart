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
}
