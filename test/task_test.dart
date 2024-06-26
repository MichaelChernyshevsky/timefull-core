@TestOn('vm')

library;

import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

void main() {
  late UserRepository userRepo;
  late TaskRepository taskRepo;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    userRepo = UserRepository(httpService: httpService);
    taskRepo = TaskRepository(httpService: httpService);
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
      final user = await userRepo.user;
      userId = user!.id;
    });
  });

  group('Taks Api', () {
    String taskId = '';
    test("-  get", () async {
      final tasks = await taskRepo.getTasksApi(userId: userId);
      taskId = tasks.tasks[0].id;
    });

    test("-  add", () async {
      expect(
          (await taskRepo.addTasksApi(
            userId: userId,
            title: '2',
            description: '2',
            date: '2',
            countOnDay: '0',
            countOnTask: '0',
          )),
          true);
    });

    test("-  edit", () async {
      expect(
          (await taskRepo.editTasksApi(
            taskId: userId,
            title: '1',
            description: '1',
            date: '0',
            countOnDay: '1',
            countOnTask: '1',
          )),
          true);
    });

    test("-  delete", () async {
      expect((await taskRepo.deleteTasksApi(taskId: taskId)), true);
    });

    // test("-  editStat", () async {
    //   expect((await taskRepo.statEditTasks(userId: userId, countDone: '20', countUnDone: '20')), true);
    // });
  });
}
