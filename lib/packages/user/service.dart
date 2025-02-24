part of '../../service.dart';

class UserService extends Repository {
  UserService({required super.httpService});
  UserModel? user;
  String? _userId;
  CollectionSchema get shema => UserModelSchema;
  late UserRepository repository;

  Future<void> initialize({required CoreModel coreModel, required Isar isar}) async {
    repository = UserRepository(httpService: httpService, isar: isar);
    _userId = await repository.userIdDB;
  }

  Future<BaseResponse> signIn({required String email, required String password}) async {
    final resp = await repository.signIn(email: email, password: password);
    _userId = resp.data['userId'].toString();
    await userGet;
    return resp;
  }

  Future<UserModel?> get userGet async {
    if (userId != '') {
      user = await repository.userGet(userId);
      return user;
    }
    return null;
  }

  bool get loggined => _userId != null && _userId != "" ?? false;

  String get userId => _userId ?? '';

  Future<RepositoryStat> editUser({
    required String userId,
    String? name,
    String? name2,
    String? sex,
    String? phone,
    int? age,
  }) async =>
      repository.editUser(
        userId: userId,
        name: name,
        name2: name2,
        sex: sex,
        phone: phone,
        age: age,
      );

  Future<void> signOut() async {
    _userId = null;
    user = null;
    repository.signOut();
  }

  Future<void> deleteUser() async {
    repository.deleteUser();
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async =>
      repository.signUp(
        email: email,
        password: password,
      );

  Future<bool> supportMessage({required String message}) async => true;
}
