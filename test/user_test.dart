@TestOn('vm')

library;

import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

const String _email = 'admin@server.com';
const String _password = 'Test12345';
Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

void main() {
  late UserRepository userRepo;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    userRepo = UserRepository(httpService: httpService);
  });

  late String userId;
  group('User Api', () {
    test("- signin", () async {
      await userRepo.signIn(email: _email, password: _password);
      expect(userRepo.loggined, true);
    });

    test("- user", () async {
      final user = await userRepo.user;
      userId = user!.id;
    });

    test("-  edit", () async {
      final resp = await userRepo.editUser(userId: userRepo.userId, sex: '', name: '', phone: '', age: 21, name2: '');
      expect(resp, true);
      await userRepo.user;
    });
  });
}
