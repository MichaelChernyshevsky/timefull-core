import 'dart:io';
import 'package:timefullcore/core.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:timefullcore/packages/economy/service.dart';

import '../const.dart';

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
    late int before;

    test("  add", () async {
      final resp = await economyService.getEconomy(coreModel: coreModelWithout);
      before = resp.length;
      expect(
        await economyService.addEconomy(
          title: 'title',
          description: 'description',
          count: 1,
          income: true,
          coreModel: coreModelWithout,
          type: 'any',
        ),
        RepositoryStat.saved,
      );
    });

    test("  check count", () async {
      final resp = await economyService.getEconomy(coreModel: coreModelWithout);
      expect(resp.length == before, false);
    });

    test("  get", () async {
      final resp = await economyService.getEconomy(coreModel: coreModelWithout);
      expect(resp.isNotEmpty, true);
    });

    test("  delete", () async {
      final id = (await economyService.getEconomy(coreModel: coreModelWithout)).first.id;
      expect((await economyService.deleteEconomy(id: id, coreModel: coreModelWithout)), RepositoryStat.deleted);
    });
    test("  check count", () async {
      final resp = await economyService.getEconomy(coreModel: coreModelWith);
      expect(resp.length == before, true);
    });
  });

  group('Economy with api:', () {
    late int before;
    test("  add", () async {
      final resp = await economyService.getEconomy(coreModel: coreModelWith);
      before = resp.length;
      expect(
        await economyService.addEconomy(
          title: 'title',
          description: 'description',
          count: 1,
          income: true,
          coreModel: coreModelWith,
          type: 'any',
          date: '111111',
        ),
        RepositoryStat.sended,
      );
    });
    test("  check count", () async {
      final resp = await economyService.getEconomy(coreModel: coreModelWith);
      expect(resp.length != before, true);
    });

    test("  delete", () async {
      final id = (await economyService.getEconomy(coreModel: coreModelWith)).first.id;
      expect((await economyService.deleteEconomy(id: id, coreModel: coreModelWith)), RepositoryStat.deleted);
    });
    test("  check count", () async {
      final resp = await economyService.getEconomy(coreModel: coreModelWith);
      expect(resp.length == before, true);
    });
  });
}
