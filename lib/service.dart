// ignore_for_file: depend_on_referenced_packages
import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/note/interface.dart';
import 'package:timefullcore/packages/note/models/model.dart';
import 'package:timefullcore/packages/note/models/note_model/model.dart';
import 'package:timefullcore/packages/note/models/page_model/model.dart';
import 'package:timefullcore/packages/tasks/service.dart';

import 'core.dart';

part 'packages/economy/repo.dart';
part 'packages/timer/repo.dart';
part 'packages/user/repo.dart';
part 'packages/packages/repo.dart';
part 'packages/tasks/repo.dart';
part 'packages/note/repo.dart';

class CoreService {
  late UserRepository userRepo;
  late PackagesRepository packageRepo;
  late EconomyRepository economyRepo;
  late TimerRepository timerRepo;
  late TaskRepository taskRepo;
  late NoteRepository noteRepo;
  late Isar isar;

  Future<void> initialize({String? location, bool? shema}) async {
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    userRepo = UserRepository(httpService: httpService);
    packageRepo = PackagesRepository(httpService: httpService);
    economyRepo = EconomyRepository(httpService: httpService);
    timerRepo = TimerRepository(httpService: httpService);
    taskRepo = TaskRepository(httpService: httpService);
    noteRepo = NoteRepository(httpService: httpService);
    await Isar.initializeIsarCore(download: true);
    if (shema == true) {
      isar = await Isar.open(
        [economyRepo.shemaEconomy, timerRepo.shemaTimer, userRepo.shemaUser, packageRepo.shemaPackages, taskRepo.shemaTask, noteRepo.shemaNote, noteRepo.shemaPage],
        directory: location ?? await localPath,
      );
    }
    userRepo.initialize(internet: false, loggined: loggined, isar: isar);
    economyRepo.initialize(internet: false, loggined: loggined, userId: userId, isar: isar);
    timerRepo.initialize(internet: false, loggined: loggined, userId: userId, isar: isar);
    packageRepo.initialize(internet: false, loggined: loggined, userId: userId, isar: isar);
    taskRepo.initialize(internet: false, loggined: loggined, userId: userId, isar: isar);
    noteRepo.initialize(internet: false, loggined: loggined, userId: userId, isar: isar);
  }

  Future<void> close() async {
    await isar.close();
  }

  void refresh() {
    economyRepo.refresh(userId: userId);
    timerRepo.refresh(userId: userId);
    taskRepo.refresh(userId: userId);
  }

  CoreModel get coreModel => CoreModel(loggined: false, internet: false, userId: '');

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
      userRepo.editUser(
        userId: userId,
        name: name,
        name2: name2,
        sex: sex,
        phone: phone,
        age: age,
      );

  Future get user async => userRepo.user;

  Future signIn({
    required String email,
    required String password,
  }) async =>
      userRepo.signIn(
        email: email,
        password: password,
      );

  void signOut() => userRepo.signOut();

  void userDelete() => userRepo.deleteUser();

  void signUp({required String email, required String password}) => userRepo.signUp(email: email, password: password);

  bool get loggined => userRepo.loggined;

  String get userId => userRepo.userId;
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
    }
    return packageRepo.changePackage(type: type, userId: userRepo.userId, interner: false);
  }

  Future<Map<String, String>> packageGet() async {
    final packages = await packageRepo.getPackages(userId: userRepo.userId, interner: false);

    return {
      'economy': packages.economy.toString(),
      'timer': packages.timer.toString(),
      'task': packages.task.toString(),
    };
  }

  Future<PackagesInfo> packageInfo() async => packageRepo.infoPackagesApi();
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

  Future<RepositoryStat> addEconomy({
    required String title,
    required String description,
    required int count,
    required int date,
    required bool income,
    bool? internet,
  }) async =>
      economyRepo.addEconomy(
        title: title,
        description: description,
        count: count,
        date: date,
        income: income,
        userId: userId,
        loggined: loggined,
        internet: internet ?? await internetConnected,
      );

  Future<List<EconomyModel>> getEconomy({bool? internet}) async => economyRepo.getEconomy(userId: userId, loggined: loggined, internet: internet ?? await internetConnected);

  Future<bool> wipeEconomy() async => economyRepo.wipeEconomy(userId: userId, loggined: loggined, internet: false);
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
  Future<bool> wipeTimer() async => timerRepo.wipe();

  Future<void> actionTimer() async => timerRepo.action(userId: userId, loggined: loggined, internet: false);

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
    await taskRepo.deleteTask(id: id, coreModel: coreModel);
    return true;
  }

  Future<bool> addTask({required TaskModel model}) async {
    await taskRepo.addTask(model: model, coreModel: coreModel);
    return true;
  }

  Future<bool> editTask({required TaskModel model}) async {
    await taskRepo.editTask(model: model, coreModel: coreModel);
    return true;
  }

  Future<TasksModels> getTasks() async {
    final models = await taskRepo.getTasks(coreModel: coreModel);
    return models;
  }

  Future<bool> wipeTasks() async {
    taskRepo.wipeTask(coreModel: coreModel);
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
  Future<void> addNote(NoteModel model) async => noteRepo.addNote(model);
  Future<void> addNoteAfterParent(NoteModel model) async => noteRepo.addNoteAfterParent(model);

  Future<void> addPage(PageModel model) async => noteRepo.addPage(model);

  Future<void> deleteNote(int id) async => noteRepo.deleteNote(id);

  Future<void> deletePage(int id) async => noteRepo.deletePage(id);

  Future<void> editNote(NoteModel model) async => noteRepo.editNote(model);

  Future<void> editPage(PageModel model) async => noteRepo.editPage(model);

  Future<List<PageWithNotes>> getPages() async => noteRepo.getPages();
  Future<PageWithNotes> getPageById(Id pageId) async => noteRepo.getPageById(pageId);

  List<String> get suffics => noteRepo.suffics;
}
