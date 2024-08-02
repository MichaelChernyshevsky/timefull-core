@TestOn('vm')

library;

import 'package:timefullcore/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timefullcore/packages/packages/service.dart';

import 'const.dart';

void main() {
  late PackagesService packagesService;
  late Isar isar;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    packagesService = PackagesService(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [packagesService.shemaPackages],
      directory: await testDirectory,
    );
  });

  group('Package without api:', () {
    test("  initialize", () async {
      await packagesService.initialize(coreModel: coreModelWithout, isar: isar);
    });
    test("  get", () async {
      final resp = await packagesService.getPackages(coreModel: coreModelWithout);
      print(resp.serialize());
      // expect(resp.userId, userRepo.userId);
    });

    test("  change", () async {
      expect(await packagesService.changePackage(type: 'task', coreModel: coreModelWithout), true);
    });
    test("  get", () async {
      final Packages resp = await packagesService.getPackages(coreModel: coreModelWithout);
      print(resp.serialize());
    });

    // test("-  info", () async {
    //   expect((await packagesService.infoPackages()).packagees.isNotEmpty, true);
    // });
  });
}
