import 'package:timefullcore/helpers/common/repository.dart';
import 'package:timefullcore/helpers/common/stateRepository.dart';
import 'package:timefullcore/packages/tasks/model.dart';
import 'package:timefullcore/packages/tasks/uri.dart';

class TaskRepository {
  final HttpService httpService;

  TaskRepository({required this.httpService});

  Future<bool> addTaskApi({
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

  Future<bool> deleteTaskApi({required String taskId}) async {
    final BaseResponse resp = await httpService.delete(deleteUri, data: {"taskId": taskId});
    return resp.message == MESSAGE_SUCCESS;
  }

  Future<bool> editTaskApi({
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

  Future<TasksModels> getTasksApi({required String userId}) async {
    final BaseResponse resp = await httpService.post(getUri, data: {"userId": userId});
    return TasksModels.fromJson(resp.data);
  }

  Future<bool> statEditTaskApi({
    required String userId,
    required String countDone,
    required String countUnDone,
  }) async {
    final BaseResponse resp = await httpService.patch(editStatUri, data: {
      "userId": userId,
      "countDone": countDone,
      "countUnDone": countUnDone,
    });
    return resp.message == MESSAGE_SUCCESS;
  }
}
