import 'package:flutter_test/flutter_test.dart';
import 'package:timefullcore/core.dart';

import '../const.dart';

void main() {
  late TaskService taskRepo;
  late Isar isar;
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    taskRepo = TaskService(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [taskRepo.shema],
      directory: await testDirectory,
    );
  });

  tearDownAll(() async {
    await isar.close();
  });

  group('Task without api:', () {
    test("  initialize", () async {
      taskRepo.initialize(coreModel: coreModelWithout, isar: isar);
    });

    test("  get empty", () async {
      final tasks = await taskRepo.getTasks(coreModel: coreModelWithout, filter: filter);
      expect(tasks.tasks.isEmpty, true);
    });

    test("  add", () async {
      await taskRepo.addTask(
        coreModel: coreModelWithout,
        model: TaskModel(tag: 'ffff', description: 'description', title: 'title', countOnTask: 1, countOnTaskDone: 1, countDoneTotal: 1, countUnDoneTotal: 1, id: null),
      );
    });

    test("  get is not empty", () async {
      final tasks = await taskRepo.getTasks(coreModel: coreModelWithout, filter: filter);
      expect(tasks.tasks.isEmpty, false);
    });

    test("  mark", () async {
      final task = (await taskRepo.getTasks(coreModel: coreModelWithout, filter: filter)).tasks[0];
      await taskRepo.markTask(modelId: task.id!, coreModel: coreModelWithout);
      final taskCheck = (await taskRepo.getTasks(coreModel: coreModelWithout, filter: filter)).tasks[0];
      expect(taskCheck.countOnTaskDone, 1);
    });
    test("  unmark", () async {
      final task = (await taskRepo.getTasks(coreModel: coreModelWithout, filter: filter)).tasks[0];
      await taskRepo.unMarkTask(modelId: task.id!, coreModel: coreModelWithout);
      final taskCheck = (await taskRepo.getTasks(coreModel: coreModelWithout, filter: filter)).tasks[0];
      expect(taskCheck.countOnTaskDone, 0);
    });
    test("  edit", () async {
      final task = (await taskRepo.getTasks(coreModel: coreModelWithout, filter: filter)).tasks[0];
      await taskRepo.editTask(model: task.copyWith(countOnTask: 10), coreModel: coreModelWithout);
      final taskCheck = (await taskRepo.getTasks(coreModel: coreModelWithout, filter: filter)).tasks[0];
      expect(taskCheck.countOnTask, 10);
    });
  });

  // group('Task with api:', () {
  //   test("  initialize", () async => taskRepo.initialize(coreModel: coreModelWith, isar: isar));

  //   late int countTasks;
  //   test("  get", () async {
  //     final tasks = await taskRepo.getTasks(coreModel: coreModelWith, filter: filter);
  //     countTasks = tasks.tasks.length;
  //     expect(tasks.tasks.isEmpty, false);
  //   });

  //   test("  add", () async {
  //     await taskRepo.addTask(
  //       coreModel: coreModelWith,
  //       model: TaskModel(
  //         description: 'description',
  //         title: 'title',
  //         countOnTask: 40,
  //         countOnTaskDone: 1,
  //         countDoneTotal: 1,
  //         countUnDoneTotal: 1,
  //         id: null,
  //       ),
  //     );
  //   });
  //   late int idLast;
  //   test("  check value", () async {
  //     final tasks = await taskRepo.getTasks(coreModel: coreModelWith, filter: filter);
  //     idLast = tasks.tasks[0].id!;
  //     expect(tasks.tasks.length > countTasks, true);
  //   });

  //   // test("  mark", () async {
  //   //   await taskRepo.markTask(modelId: idLast, coreModel: coreModelWith);
  //   //   final taskCheck = (await taskRepo.getTasks(coreModel: coreModelWith)).tasks[0];
  //   //   expect(taskCheck.countOnTaskDone, 1);
  //   // });
  //   // test("  unmark", () async {
  //   //   await taskRepo.unMarkTask(modelId: idLast, coreModel: coreModelWith);
  //   //   final taskCheck = (await taskRepo.getTasks(coreModel: coreModelWith)).tasks[0];
  //   //   expect(taskCheck.countOnTaskDone, 0);
  //   // });
  //   // test("  edit", () async {
  //   //   final task = (await taskRepo.getTasks(coreModel: coreModelWith)).tasks[0];
  //   //   await taskRepo.editTask(model: task.copyWith(countOnTask: 10), coreModel: coreModelWith);
  //   //   final taskCheck = (await taskRepo.getTasks(coreModel: coreModelWith)).tasks[0];
  //   //   expect(taskCheck.countOnTask, 10);
  //   // });
  // });
}
