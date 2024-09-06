import 'package:flutter_test/flutter_test.dart';
import 'package:timefullcore/core.dart';
import 'package:timefullcore/packages/sport/model.dart';
import 'package:timefullcore/packages/sport/service.dart';

import '../const.dart';

void main() {
  late SportService service;
  late Isar isar;
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    service = SportService(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [service.shemaSport],
      directory: await testDirectory,
    );
  });

  tearDownAll(() async {
    await isar.close();
  });

  // group('Sport without api:', () {
  //   test("  initialize", () async {
  //     service.initialize(coreModel: coreModelWithout, isar: isar);
  //   });

  //   test("  get empty", () async {
  //     final tasks = await service.getTasks(coreModel: coreModelWithout);
  //     expect(tasks.tasks.isEmpty, true);
  //   });

  //   test("  add", () async {
  //     await service.addTask(
  //       coreModel: coreModelWithout,
  //       model: TaskModel(description: 'description', title: 'title', countOnTask: 1, countOnTaskDone: 1, countDoneTotal: 1, countUnDoneTotal: 1, id: null),
  //     );
  //   });

  //   test("  get is not empty", () async {
  //     final tasks = await service.getTasks(coreModel: coreModelWithout);
  //     expect(tasks.tasks.isEmpty, false);
  //   });

  //   test("  mark", () async {
  //     final task = (await service.getTasks(coreModel: coreModelWithout)).tasks[0];
  //     await service.markTask(modelId: task.id!, coreModel: coreModelWithout);
  //     final taskCheck = (await service.getTasks(coreModel: coreModelWithout)).tasks[0];
  //     expect(taskCheck.countOnTaskDone, 1);
  //   });
  //   test("  unmark", () async {
  //     final task = (await service.getTasks(coreModel: coreModelWithout)).tasks[0];
  //     await service.unMarkTask(modelId: task.id!, coreModel: coreModelWithout);
  //     final taskCheck = (await service.getTasks(coreModel: coreModelWithout)).tasks[0];
  //     expect(taskCheck.countOnTaskDone, 0);
  //   });
  //   test("  edit", () async {
  //     final task = (await service.getTasks(coreModel: coreModelWithout)).tasks[0];
  //     await service.editTask(model: task.copyWith(countOnTask: 10), coreModel: coreModelWithout);
  //     final taskCheck = (await service.getTasks(coreModel: coreModelWithout)).tasks[0];
  //     expect(taskCheck.countOnTask, 10);
  //   });
  // });

  group('Sport with api:', () {
    test("  initialize", () async => service.initialize(coreModel: coreModelWith, isar: isar));
    late SportModels models;
    test("  get", () async {
      models = await service.get(coreModel: coreModelWith);
      expect(models.isNotEmpty, true);
    });

    test("  add", () async {
      await service.add(
        coreModel: coreModelWith,
        title: 'T',
        distant: 5,
        date: '1931313133',
      );
      final models_2 = await service.get(coreModel: coreModelWith);
      expect(models_2.length > models.length, true);
    });

    test("  delete", () async {
      await service.delete(coreModel: coreModelWith, id: models[0].id!);
      final models_2 = await service.get(coreModel: coreModelWith);
      expect(models_2.length == models.length, true);
    });
  });
}
