import 'dart:io';
import 'package:timefullcore/core.dart';

import 'package:flutter_test/flutter_test.dart';

import '../const.dart';

Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

void main() {
  late TimerService timerRepo;
  late Isar isar;
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    timerRepo = TimerService(httpService: httpService);
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [timerRepo.shema],
      directory: await testDirectory,
    );
  });

  tearDownAll(() async {
    await isar.close();
  });

  group('Timer without api:', () {
    test(
      "  initialize",
      () async => await timerRepo.initialize(
        coreModel: coreModelWithout,
        isar: isar,
      ),
    );
  });

  group('Timer with api:', () {
    test(
      " initialize",
      () async => await timerRepo.initialize(
        coreModel: coreModelWith,
        isar: isar,
      ),
    );
  });

  // group('Set user', () {
  //   test("- signin", () async {
  //     const String email = 'admin@server.com';
  //     const String password = 'Test12345';
  //     await userRepo.signIn(email: email, password: password);
  //     expect(userRepo.loggined, true);
  //   });
  //   test("- user", () async {
  //     final user = userRepo.user;
  //     userId = user.id.toString();
  //   });
  // });

  // group('Timer Api', () {
  //   test("-  get", () async {
  //     await timerRepo.getTimerApi(userId: userId);
  //     expect(await timerRepo.model != null, true);
  //   });
  //   test("-  editHistory", () async {
  //     expect((await timerRepo.editTimerHistoryApi(userId: userId, work: '1', relax: '1')), true);
  //   });

  //   test("-  editStat", () async {
  //     expect((await timerRepo.editTimerStatApi(userId: userId, timeWork: '', timeRelax: '')), true);
  //   });
  // });

  // group('Timer Isar', () {
  //   int relax = 0;
  //   test("-  add relax without internet 1", () async {
  //     final resp = await timerRepo.addTimeRelax(userId: userId, loggined: false, internet: false, time: 1);
  //     expect(resp == RepositoryStat.saved, true);
  //     relax = (await timerRepo.model)!.timeRelaxSave;
  //   });

  //   test("-  add relax without internet 2", () async {
  //     final resp = await timerRepo.addTimeRelax(userId: userId, loggined: false, internet: false, time: 1);
  //     expect(resp == RepositoryStat.saved, true);
  //   });
  //   test("-  saving", () async {
  //     final relax0 = (await timerRepo.model)!.timeRelaxSave;
  //     expect(relax0 > relax, true);
  //   });

  //   test("-  add relax with internet", () async {
  //     final resp = await timerRepo.addTimeRelax(userId: userId, loggined: true, internet: true, time: 1);
  //     expect(resp == RepositoryStat.sended, true);
  //   });

  //   int work = 0;

  //   test("-  add work without internet 1", () async {
  //     final resp = await timerRepo.addTimeWork(userId: userId, loggined: false, internet: false, time: 1);
  //     expect(resp == RepositoryStat.saved, true);
  //     work = (await timerRepo.model)!.timeRelaxSave;
  //   });

  //   test("-  add work without internet 2", () async {
  //     final resp = await timerRepo.addTimeWork(userId: userId, loggined: false, internet: false, time: 1);
  //     expect(resp == RepositoryStat.saved, true);
  //   });
  //   test("-  saving", () async {
  //     final work0 = (await timerRepo.model)!.timeWorkSave;
  //     expect(work0 > work, true);
  //   });

  //   test("-  add work with internet", () async {
  //     final resp = await timerRepo.addTimeWork(userId: userId, loggined: true, internet: true, time: 1);
  //     expect(resp == RepositoryStat.sended, true);
  //   });
  // });
}
