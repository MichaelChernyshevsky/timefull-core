import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

const String _email = 'admin@server.com';
const String _password = 'Test12345';
Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

void main() {
  late UserRepository userRepo;
  late CoreService coreService;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    userRepo = UserRepository(httpService: httpService);
    coreService = CoreService();
  });

  late String userId;
  test("- signin", () async {
    await userRepo.signIn(email: _email, password: _password);
    expect(userRepo.loggined, true);
  });

  group('Core ', () {
    test("- initialize", () async {
      coreService.initialize(location: await testDirectory);
    });

    test("- signin", () async {
      await coreService.signIn(email: _email, password: _password);
      expect(userRepo.loggined, true);
    });

    test("- user", () async {
      final user = await coreService.user;
      userId = user!.id;
    });

    test("- user edit", () async {
      final resp = await coreService.userEdit(
        sex: '',
        name: '',
        phone: '',
        age: 21,
        name2: '',
      );
      expect(resp, true);
      await userRepo.user;
    });

    test("- package get", () async {
      final resp = await coreService.packageGet();
      expect(resp.userId, userRepo.userId);
    });

    test("- package change", () async {
      expect(await coreService.packageChange(type: PackageType.task), true);
    });

    test("- package info", () async {
      expect((await coreService.packageInfo()).packagees.isNotEmpty, true);
    });

    bool loggined = true;
    bool internet = true;

    test("- economy add without internet", () async {
      expect(
        await coreService.addEconomy(
          title: 'title',
          description: 'description',
          count: 1,
          date: 1,
          income: true,
          userId: '',
          loggined: false,
          internet: false,
        ),
        true,
      );
    });

    test("- economy add with internet", () async {
      expect(
        await coreService.addEconomy(
          title: 'title',
          description: 'description',
          count: 1,
          date: 1,
          income: true,
          userId: userId,
          loggined: false,
          internet: true,
        ),
        true,
      );
    });

    test("- economy get with internet", () async {
      final resp = await coreService.getEconomy(internet: false);
      expect(resp.isNotEmpty, true);
    });

    test("- economy get without internet", () async {
      final resp = await coreService.getEconomy(internet: internet);
      expect(resp.isNotEmpty, true);
    });
  });
}
