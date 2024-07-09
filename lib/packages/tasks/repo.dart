part of '../../service.dart';

class TaskRepository extends Repository implements TaskInterface {
  TaskRepository({required super.httpService});

  late Isar _isar;
  CollectionSchema get shemaTask => TaskModelSchema;

  Future<void> initialize({required bool internet, required bool loggined, required String userId, required Isar isar}) async {
    _isar = isar;
    if (internet && loggined) await refresh(userId: userId);
  }

  Future<void> refresh({required String userId}) async {}

  @override
  Future<bool> addTasksApi({
    required String userId,
    required String title,
    required String description,
    required String date,
    required String countOnDay,
    required String countOnTask,
  }) async {
    final BaseResponse resp = await httpService.post(addUri, data: {
      "userId": userId,
      "title": title,
      "description": description,
      "date": date,
      "countOnDay": int.parse(countOnDay),
      "countOnTask": int.parse(countOnTask),
    });
    return resp.message == MESSAGE_SUCCESS;
  }

  @override
  Future<bool> deleteTasksApi({required String taskId}) async {
    final BaseResponse resp = await httpService.delete(deleteUri, data: {"taskId": taskId});
    return resp.message == MESSAGE_SUCCESS;
  }

  @override
  Future<bool> editTasksApi({
    required String taskId,
    required String title,
    required String description,
    required String date,
    required String countOnDay,
    required String countOnTask,
  }) async {
    final BaseResponse resp = await httpService.patch(editUri, data: {
      "taskId": taskId,
      "title": title,
      "description": description,
      "date": date,
      "countOnDay": countOnDay,
      "countOnTask": countOnTask,
    });
    return resp.message == MESSAGE_SUCCESS;
  }

  @override
  Future<TasksModels> getTasksApi({required String userId}) async {
    final BaseResponse resp = await httpService.post(getUri, data: {"userId": userId});
    return TasksModels.fromJson(resp.data);
  }

  @override
  Future<bool> statEditTasksApi({required String userId, required String countDone, required String countUnDone}) async {
    final BaseResponse resp = await httpService.patch(editStatUri, data: {
      "userId": userId,
      "countDone": countDone,
      "countUnDone": countUnDone,
    });
    return resp.message == MESSAGE_SUCCESS;
  }

  @override
  Future<void> deleteTask({required int id, required bool internet, required bool loggined, required String userId}) async {
    await _isar.writeTxn(() async => await _isar.economyModels.delete(id));
  }

  @override
  Future<void> editTask({required TaskModel model, required bool internet, required bool loggined, required String userId}) async {
    await _isar.writeTxn(() async => await _isar.taskModels.put(model));
  }

  @override
  Future<void> addTask({required TaskModel model, required bool internet, required bool loggined, required String userId}) async {
    await _isar.writeTxn(() async => _isar.taskModels.put(model));
  }

  @override
  Future<TasksModels> getTasks({required bool internet, required bool loggined, required String userId}) async {
    final tasks = await _isar.taskModels.where().findAll();
    return TasksModels(tasks);
  }

  @override
  Future<void> wipeTask({required bool internet, required bool loggined, required String userId}) async {
    await _isar.writeTxn(() async => await _isar.taskModels.clear());
  }
}
