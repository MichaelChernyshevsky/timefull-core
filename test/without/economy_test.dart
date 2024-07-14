import 'dart:io';
import 'package:timefullcore/core.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:timefullcore/packages/economy/service.dart';

import 'const.dart';

Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

void main() {
  late EconomyService economyService;
  late Isar isar;
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    economyService = EconomyService(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [economyService.shemaEconomy],
      directory: await testDirectory,
    );
  });

  tearDownAll(() async {
    await isar.close();
  });

  group('Economy without api:', () {
    test(
      "  initialize",
      () async => await economyService.initialize(
        coreModel: coreModelWithout,
        isar: isar,
      ),
    );
    test("  add", () async {
      expect(
        await economyService.addEconomy(
          title: 'title',
          description: 'description',
          count: 1,
          income: true,
          coreModel: coreModelWithout,
        ),
        RepositoryStat.saved,
      );
    });

    test("  get", () async {
      final resp = await economyService.getEconomy(coreModel: coreModelWithout);
      expect(resp.isNotEmpty, true);
    });

    test("  delete", () async {
      final id = (await economyService.getEconomy(coreModel: coreModelWithout)).first.id;
      expect((await economyService.deleteEconomy(id: id, coreModel: coreModelWithout)), RepositoryStat.deleted);
    });
  });
}
