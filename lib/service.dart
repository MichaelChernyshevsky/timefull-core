// ignore_for_file: depend_on_referenced_packages

import 'package:core/packages/packages/func.dart';

import 'core.dart';

part 'packages/economy/repo.dart';
part 'packages/timer/repo.dart';
part 'packages/user/repo.dart';
part 'packages/packages/repo.dart';
part 'packages/tasks/repo.dart';

class CoreService {
  late UserRepository userRepo;
  late PackagesRepository packageRepo;
  late EconomyRepository economyRepo;
  late TimerRepository timerRepo;
  late TaskRepository taskRepo;
  late Isar isar;

  Future<void> initialize({String? location, bool? shema}) async {
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    userRepo = UserRepository(httpService: httpService);
    packageRepo = PackagesRepository(httpService: httpService);
    economyRepo = EconomyRepository(httpService: httpService);
    timerRepo = TimerRepository(httpService: httpService);
    taskRepo = TaskRepository(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    if (shema == true) {
      isar = await Isar.open(
        [economyRepo.shemaEconomy, timerRepo.shemaTimer],
        directory: location ?? await localPath,
      );
    }

    economyRepo.initialize(internet: false, loggined: loggined, userId: userId, isar: isar);
    timerRepo.initialize(internet: false, loggined: loggined, userId: userId, isar: isar);
  }

  Future<void> close() async {
    await isar.close();
  }

  void refresh() {
    economyRepo.refresh(userId: userId);
    timerRepo.refresh(userId: userId);
    taskRepo.refresh(userId: userId);
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
  Future<bool> packageChange({required PackageType type}) async => packageRepo.changePackage(type: type, userId: userRepo.userId);

  Future<Packages> packageGet() async => packageRepo.getPackages(userId: userRepo.userId);

  Future<PackagesInfo> packageInfo() async => packageRepo.infoPackages();
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
    required String userId,
    required bool loggined,
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

  Future<bool> wipeEconomy() async {
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

  Future<bool> deleteTasks({required String id}) async {
    return true;
  }

  Future<bool> addTasks({required TaskModel element}) async {
    return true;
  }

  Future<TasksModels> getTasks() async {
    return TasksModels([]);
  }

  Future<bool> tasksWipe() async {
    return true;
  }
}
