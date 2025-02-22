// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:timefullcore/helpers/api/models/filter_model.dart';
import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/economy/repository.dart';
import 'package:timefullcore/packages/note/interface.dart';
import 'package:timefullcore/packages/note/models/model.dart';
import 'package:timefullcore/packages/note/models/note_model/model.dart';
import 'package:timefullcore/packages/note/models/page_model/model.dart';
import 'package:timefullcore/packages/packages/service.dart';
import 'package:timefullcore/packages/sport/service.dart';
import 'package:timefullcore/packages/tasks/repository.dart';
import 'package:timefullcore/packages/timer/repository.dart';
import 'package:timefullcore/packages/user/repository.dart';

import 'core.dart';
import 'packages/economy/service.dart';

part 'packages/timer/service.dart';
part 'packages/user/service.dart';
part 'packages/tasks/service.dart';
part 'packages/note/service.dart';

class CoreService {
  late UserService userService;
  late TimerService timerService;
  late PackagesService packageService;
  late EconomyService economyService;
  late TaskService taskService;
  late NoteService noteService;
  late SportService sportService;
  late Isar isar;

  Future<void> initialize({String? location, bool? shema}) async {
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    userService = UserService(httpService: httpService);
    packageService = PackagesService(httpService: httpService);
    economyService = EconomyService(httpService: httpService);
    timerService = TimerService(httpService: httpService);
    taskService = TaskService(httpService: httpService);
    noteService = NoteService(httpService: httpService);
    sportService = SportService(httpService: httpService);
    await Isar.initializeIsarCore(download: true);
    if (shema == true) {
      isar = await Isar.open(
        [economyService.shemaEconomy, timerService.shemaTimer, userService.shemaUser, packageService.shemaPackages, taskService.shemaTask, noteService.shemaNote, noteService.shemaPage],
        directory: location ?? await localPath,
      );
    }
    userService.initialize(coreModel: coreModel, isar: isar);
    economyService.initialize(coreModel: coreModel, isar: isar);
    timerService.initialize(coreModel: coreModel, isar: isar);
    packageService.initialize(coreModel: coreModel, isar: isar);
    taskService.initialize(coreModel: coreModel, isar: isar);
    noteService.initialize(internet: false, loggined: loggined, userId: userId, isar: isar);
  }

  Future<void> close() async {
    await isar.close();
  }

  void refresh() {
    economyService.refresh(coreModel: coreModel);
    timerService.refresh(userId: userId);
    taskService.refresh(userId: userId);
  }

  void importdb(Map<String, dynamic> db) {
    if (db.containsKey('economy')) {
      economyService.importdb(db['economy']);
    } else {
      throw Exception('"economy" not found in the database');
    }

    if (db.containsKey('timer')) {
      timerService.importdb(db['timer']);
    } else {
      throw Exception(' "timer" not found in the database');
    }

    if (db.containsKey('tasks')) {
      taskService.importdb(db['tasks']);
    } else {
      throw Exception(' "tasks" not found in the database');
    }

    if (db.containsKey('note')) {
      noteService.importdb(db['sport']);
    } else {
      throw Exception(' "sport" not found in the database');
    }

    if (db.containsKey('sport')) {
      sportService.importdb(db['sport']);
    } else {
      throw Exception(' "sport" not found in the database');
    }
  }

  Future<Map<String, dynamic>> exportdb() async {
    return {
      'economy': await economyService.exportdb(),
      'sport': sportService.exportdb(),
      'tasks': await taskService.exportdb(),
      'timer': timerService.exportdb(),
    };
  }

  CoreModel get coreModel => CoreModel(loggined: false, internet: false, userId: '', isWeb: kIsWeb);

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //  User
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  Future<RepositoryStat> userEdit({
    String? name,
    String? name2,
    String? sex,
    String? phone,
    int? age,
  }) async =>
      userService.editUser(
        userId: userId,
        name: name,
        name2: name2,
        sex: sex,
        phone: phone,
        age: age,
      );

  Future get user async => userService.user;

  Future signIn({
    required String email,
    required String password,
  }) async =>
      userService.signIn(
        email: email,
        password: password,
      );

  void signOut() => userService.signOut();

  void userDelete() => userService.deleteUser();

  void signUp({required String email, required String password}) => userService.signUp(email: email, password: password);

  bool get loggined => userService.loggined;

  String get userId => userService.userId;
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //   Package
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  Future<bool> packageChange({required String type}) async {
    if (type == 'economy') {
      // packages!.economy = !packages!.economy;
    } else if (type == 'timer') {
      // packages!.timer = !packages!.timer;
    } else if (type == 'task') {
      // packages!.task = !packages!.task;
    } else if (type == 'note') {
      // packages!.task = !packages!.task;
    } else if (type == 'sport') {
      // packages!.task = !packages!.task;
    }
    return packageService.changePackage(type: type, coreModel: coreModel);
  }

  Future<Map<String, dynamic>> getPackages() async {
    final packages = await packageService.getPackages(coreModel: coreModel);
    return packages.serialize();
  }

  // Future<PackagesInfo> packageInfo() async => packageRepo.infoPackagesApi();
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //  Economy
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

  Future<bool> deleteEconomy({required String id}) async {
    return true;
  }

  Future<Map<String, int>> getStat() async => economyService.getStat();

  Future<RepositoryStat> addEconomy({
    required String title,
    required String type,
    required String description,
    required int count,
    required int date,
    required bool income,
    bool? internet,
  }) async =>
      economyService.addEconomy(
        title: title,
        type: type,
        description: description,
        count: count,
        date: date.toString(),
        income: income,
        coreModel: coreModel,
      );

  Future<List<EconomyModel>> getEconomy({bool? internet}) async => economyService.getEconomy(coreModel: coreModel);

  Future<bool> wipeEconomy() async => economyService.wipeEconomy(userId: userId, loggined: loggined, internet: false);

  Future<List<String>> get listTypesEconomy async => economyService.listTypes;

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //  Timer
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  Future<bool> wipeTimer() async => timerService.wipe();

  Future<void> actionTimer() async => timerService.action(userId: userId, loggined: loggined, internet: false);

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //  Tasks
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

  Future<bool> deleteTask({required int id}) async {
    await taskService.deleteTask(id: id, coreModel: coreModel);
    return true;
  }

  Future<bool> addTask({required TaskModel model}) async {
    await taskService.addTask(model: model, coreModel: coreModel);
    return true;
  }

  Future<bool> editTask({required TaskModel model}) async {
    await taskService.editTask(model: model, coreModel: coreModel);
    return true;
  }

  Future<TasksModels> getTasks(FilterRequestModel filter) async {
    final models = await taskService.getTasks(coreModel: coreModel, filter: filter);
    return models;
  }

  Future<bool> wipeTasks() async {
    taskService.wipeTask(coreModel: coreModel);
    return true;
  }

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //  Note
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  Future<void> addNote(NoteModel model) async => noteService.addNote(model);
  Future<void> addNoteAfterParent(NoteModel model) async => noteService.addNoteAfterParent(model);

  Future<void> addPage(PageModel model) async => noteService.addPage(model);

  Future<void> deleteNote(int id) async => noteService.deleteNote(id);

  Future<void> deletePage(int id) async => noteService.deletePage(id);

  Future<void> editNote(NoteModel model) async => noteService.editNote(model);

  Future<void> editPage(PageModel model) async => noteService.editPage(model);

  Future<List<PageWithNotes>> getPages() async => noteService.getPages();
  Future<PageWithNotes> getPageById(Id pageId) async => noteService.getPageById(pageId);

  List<String> get suffics => noteService.suffics;
}
