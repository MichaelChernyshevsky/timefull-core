import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

void main() {
  late UserRepository userRepo;
  late EconomyRepository economyRepo;
  late Isar isar;
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    userRepo = UserRepository(httpService: httpService);
    economyRepo = EconomyRepository(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [
        economyRepo.shemaEconomy,
      ],
      directory: await testDirectory,
    );
  });

  tearDownAll(() async {
    await isar.close();
  });

  bool loggined = false;
  String userId0 = '0';
  String userId = '0';

  bool internet = false;

  test(
    "Economy -  initialize",
    () async => await economyRepo.initialize(
      internet: internet,
      loggined: loggined,
      userId: userId0,
      isar: isar,
    ),
  );

  group('Set user', () {
    test("- signin", () async {
      const String email = 'admin@server.com';
      const String password = 'Test12345';
      await userRepo.signIn(email: email, password: password);
      expect(userRepo.loggined, true);
    });
    test("- user", () async {
      final user = await userRepo.user;
      userId = user!.id;
    });
  });

  group('Economy Api', () {
    test("-  add", () async {
      expect(
        await economyRepo.addEconomyApi(
          title: 'title',
          description: 'description',
          count: 1,
          date: 1,
          income: 1,
          userId: userId,
        ),
        RepositoryStat.resp_success,
      );
    });

    late String economyId;
    test("-  get", () async {
      final resp = await economyRepo.getEconomyApi(
        userId: userId,
      );
      economyId = resp[0].id.toString();
      expect(resp.isNotEmpty, true);
    });

    test("-  delete", () async {
      expect((await economyRepo.deleteEconomyApi(id: economyId, userId: userId)), RepositoryStat.resp_success);
    });
  });

  group('Economy isar without login', () {
    test("-  add", () async {
      final resp = await economyRepo.addEconomy(
        title: 'title',
        description: 'description',
        count: 1,
        date: 1,
        income: true,
        userId: userId0,
        loggined: loggined,
        internet: internet,
      );
      expect(
        resp == RepositoryStat.saved,
        true,
      );
    });

    late int economyId;
    test("-  get", () async {
      final resp = await economyRepo.getEconomy(
        userId: userId0,
        loggined: loggined,
        internet: internet,
      );
      economyId = resp[0].id;
      expect(resp.isNotEmpty, true);
    });

    test("-  delete", () async {
      final resp = await economyRepo.deleteEconomy(
        id: economyId,
        loggined: loggined,
        internet: internet,
        userId: userId,
      );
      expect(resp == RepositoryStat.deleted, true);
    });
  });
  group('Economy isar with login', () {
    bool loggined = true;
    bool internet = true;

    test("-  add without internet", () async {
      final resp = await economyRepo.addEconomy(
        title: 'title',
        description: 'description',
        count: 1,
        date: 1,
        income: true,
        userId: userId,
        loggined: false,
        internet: false,
      );
      expect(
        resp == RepositoryStat.saved,
        true,
      );
    });

    test("-  add with internet", () async {
      final resp = await economyRepo.addEconomy(
        title: 'title',
        description: 'description',
        count: 1,
        date: 1,
        income: true,
        userId: userId,
        loggined: loggined,
        internet: internet,
      );
      expect(
        resp == RepositoryStat.sended,
        true,
      );
    });
    late int economyId;
    test("-  get ", () async {
      final resp = await economyRepo.getEconomy(userId: userId, loggined: loggined, internet: internet);
      economyId = resp[0].id;
      expect(resp.isNotEmpty, true);
    });

    test("-  delete", () async {
      final resp = await economyRepo.deleteEconomy(
        id: economyId,
        loggined: loggined,
        internet: internet,
        userId: userId,
      );
      expect(resp == RepositoryStat.deleted, true);
    });
  });
}
