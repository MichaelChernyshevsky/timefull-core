@TestOn('vm')

library;

import 'dart:io';
import 'package:timefullcore/core.dart';

import 'package:flutter_test/flutter_test.dart';

import '../const.dart';

const String _email = 'admin@server.com';
const String _password = 'Test12345';
Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

void main() {
  late UserService service;
  late Isar isar;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    service = UserService(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [service.shemaUser],
      directory: await testDirectory,
    );
    service.initialize(coreModel: coreModelWithout, isar: isar);
  });

  group('User Api', () {
    test("- signin", () async {
      await service.signIn(email: _email, password: _password);
      expect(service.loggined, true);
    });

    test("- user", () async {
      final user = service.user;
      expect(user != null, true);
    });

    test("-  edit", () async {
      final resp = await service.editUser(userId: service.userId, sex: 'men', name: '', phone: '', age: 100, name2: '');
      expect(resp == RepositoryStat.resp_success, true);
    });

    test("- signout", () async {
      await service.signOut();
      expect(service.loggined, false);
    });
  });
}
