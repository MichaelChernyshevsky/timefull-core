part of '../../service.dart';

class TaskService extends Repository implements TaskInterface {
  final TaskRepository repository;
  late Isar _isar;

  TaskService({required super.httpService}) : repository = TaskRepository(httpService: httpService);

  CollectionSchema get shemaTask => TaskModelSchema;

  Future<void> initialize({
    required CoreModel coreModel,
    required Isar isar,
  }) async {
    _isar = isar;
    if (coreModel.internet && coreModel.loggined) await refresh(userId: coreModel.userId);
  }

  int get todayDateMilliseconds {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
  }

  Future<void> refresh({required String userId}) async => await _isar.writeTxn(() async {
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
            task.countUnDoneTotal += millisecondsToDays(todayDateMilliseconds - task.date!) - 1;
            task.date = todayDateMilliseconds;

            await _isar.taskModels.put(task);
          }
        }
      });

  @override
  Future<void> deleteTask({required int id, required CoreModel coreModel}) async {
    await _isar.writeTxn(() async => await _isar.economyModels.delete(id));
  }

  @override
  Future<void> editTask({required TaskModel model, required CoreModel coreModel}) async {
    await _isar.writeTxn(() async => await _isar.taskModels.put(model));
  }

  @override
  Future<void> addTask({required TaskModel model, required CoreModel coreModel}) async {
    model.id ??= DateTime.now().millisecondsSinceEpoch;
    model.date ??= todayDateMilliseconds;
    if (coreModel.internet && coreModel.loggined) {
      final resp = await repository.addTaskApi(
        userId: coreModel.userId,
        title: model.title,
        description: model.description,
        date: model.date.toString(),
        countOnDay: '0',
        countOnTask: model.countOnTask.toString(),
      );
      if (resp) {
        await _isar.writeTxn(() async => _isar.taskModels.put(model));
      }
    } else {
      await _isar.writeTxn(() async => _isar.taskModels.put(model));
    }
  }

  @override
  Future<TasksModels> getTasks({required CoreModel coreModel, required FilterRequestModel filter}) async {
    if (coreModel.internet && coreModel.loggined) {
      final tasks = await repository.getTasksApi(userId: coreModel.userId, filter: filter);
      await _isar.writeTxn(() async {
        await _isar.taskModels.clear();
        await _isar.taskModels.putAll(tasks.tasks);
      });
    }
    final tasks = await _isar.taskModels.where().findAll();
    return TasksModels(tasks);
  }

  @override
  Future<void> markTask({required int modelId, required CoreModel coreModel}) async => await _isar.writeTxn(() async {
        if (coreModel.internet && coreModel.loggined) {}

        final task = await _isar.taskModels.where().idEqualTo(modelId).findFirst();
        if (task!.countOnTask == task.countOnTaskDone) {
        } else {
          task.countOnTaskDone += 1;
        }
        await _isar.taskModels.put(task);
      });

  @override
  Future<void> unMarkTask({required int modelId, required CoreModel coreModel}) async => await _isar.writeTxn(() async {
        if (coreModel.internet && coreModel.loggined) {}

        final task = await _isar.taskModels.where().idEqualTo(modelId).findFirst();
        if (task!.countOnTaskDone == 0) {
        } else {
          task.countOnTaskDone -= 1;
        }
        await _isar.taskModels.put(task);
      });

  @override
  Future<void> wipeTask({required CoreModel coreModel}) async {
    if (coreModel.internet && coreModel.loggined) {}

    await _isar.writeTxn(() async => await _isar.taskModels.clear());
  }
}
