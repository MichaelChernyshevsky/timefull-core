part of '../../service.dart';

class TaskRepository extends Repository implements TaskInterface {
  TaskRepository({required super.httpService});

  Future initialize() async {}

  void refresh({required String userId}) {}

  // List<TaskModel> get() {
  // }

  // Future<bool> add({
  //   required TaskModel task,
  // }) async {
  // }

  // Future edit({
  //   required TaskModel element,
  //   // required int index,
  // }) async {
  //   // final elementIndex = task.id;
  // }

  // Future<bool> delete({
  //   required String id,
  // }) async {
  //   int getIndex({required String id, required Box box}) {
  //     for (var index = 0; index <= box.length; index += 1) {
  //       if (box.values.elementAt(index).id == id) {
  //         return index;
  //       }
  //     }
  //     return -1;
  //   }

  //   final indexElement = getIndex(id: id, box: boxTasks);
  //   await boxTasks.deleteAt(indexElement);
  //   return true;
  // }

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
}
