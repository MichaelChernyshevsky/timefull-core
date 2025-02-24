import 'package:flutter_test/flutter_test.dart';
import 'package:timefullcore/core.dart';

import 'package:timefullcore/packages/styles/model.dart';
import 'package:timefullcore/packages/styles/service.dart';

import '../const.dart';

void main() {
  late StyleService service;
  late Isar isar;
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    service = StyleService(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [service.shema],
      directory: await testDirectory,
    );
  });

  tearDownAll(() async {
    await isar.close();
  });

  group('Style without api:', () {
    test("  initialize", () async => service.initialize(coreModel: coreModelWithout, isar: isar));
    late Styles models;
    late Map<String, dynamic> db;

    test("  add", () async {
      final isAdd = await service.add(
        coreModel: coreModelWithout,
        icon: '1',
        color: '1',
      );

      expect(isAdd, true);
    });

    test("  get", () async {
      models = await service.get(coreModel: coreModelWithout);
    });

    test("  export", () async {
      db = await service.exportdb();
    });

    test("  delete", () async {
      await service.delete(coreModel: coreModelWithout, id: models[0].id);
      final models_2 = await service.get(coreModel: coreModelWithout);
      expect(models_2.length != models.length, true);
    });

    test("  import", () async {
      await service.importdb(db);
      await Future.delayed(const Duration(seconds: 1), () {});
      models = await service.get(coreModel: coreModelWithout);
      expect(models.isNotEmpty, true);
    });
  });
}
