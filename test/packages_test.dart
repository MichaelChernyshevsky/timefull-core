@TestOn('vm')

library;

import 'dart:io';
import 'package:timefullcore/core.dart';

import 'package:flutter_test/flutter_test.dart';

const String _email = 'admin@server.com';
const String _password = 'Test12345';
Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

void main() {
  late UserRepository userRepo;
  late PackagesRepository packageRepo;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    userRepo = UserRepository(httpService: httpService);
    packageRepo = PackagesRepository(httpService: httpService);
  });

  late String userId;
  group('Set user', () {
    test("- signin", () async {
      const String email = 'admin@server.com';
      const String password = 'Test12345';
      await userRepo.signIn(email: email, password: password);
      expect(userRepo.loggined, true);
    });
    test("- user", () async {
      final user = userRepo.user;
      userId = user.id.toString();
    });
  });
  group('Package Api', () {
    test("-  get", () async {
      final resp = await packageRepo.getPackagesApi(userId: userId);
      expect(resp.userId, userRepo.userId);
    });

    test("-  change", () async {
      expect(await packageRepo.changePackageApi(type: PackageType.task, userId: userId), true);
    });
    test("-  get", () async {
      final Packages resp = await packageRepo.getPackagesApi(userId: userId);
      print(resp.serialize());
    });

    test("-  info", () async {
      expect((await packageRepo.infoPackagesApi()).packagees.isNotEmpty, true);
    });
  });
}
