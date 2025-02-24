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
      [service.shema],
      directory: await testDirectory,
    );
  });

  tearDownAll(() async {
    await isar.close();
  });

  group('Sport without api:', () {
    test("  initialize", () async => service.initialize(coreModel: coreModelWithout, isar: isar));
    late SportModels models;
    late Map<String, dynamic> db;

    test("  add", () async {
      final isAdd = await service.add(
        coreModel: coreModelWithout,
        title: 'T',
        distant: 5,
        date: '1000',
      );

      expect(isAdd, true);
    });

    test("  get", () async {
      models = await service.get(coreModel: coreModelWithout, filter: filter);
    });

    test("  export", () async {
      db = await service.exportdb();
    });

    test("  delete", () async {
      await service.delete(coreModel: coreModelWithout, id: models[0].id!);
      final models_2 = await service.get(coreModel: coreModelWithout, filter: filter);
      expect(models_2.length != models.length, true);
    });

    test("  import", () async {
      await service.importdb(db);
      models = await service.get(coreModel: coreModelWithout);
      expect(models.isNotEmpty, true);
    });
  });

  // group('Sport with api:', () {
  //   test("  initialize", () async => service.initialize(coreModel: coreModelWith, isar: isar));
  //   late SportModels models;
  //   test("  get", () async {
  //     models = await service.get(coreModel: coreModelWith, filter: filter);
  //     print(models.length);
  //     expect(models.isNotEmpty, true);
  //   });

  //   test("  add", () async {
  //     await service.add(
  //       coreModel: coreModelWith,
  //       title: 'T',
  //       distant: 5,
  //       date: '1000',
  //     );
  //     final models_2 = await service.get(coreModel: coreModelWith, filter: filter);
  //     expect(models_2.length > models.length, true);
  //   });

  //   test("  delete", () async {
  //     await service.delete(coreModel: coreModelWith, id: models[0].id!);
  //     final models_2 = await service.get(coreModel: coreModelWith, filter: filter);
  //     expect(models_2.length == models.length, true);
  //   });
  // });
}
