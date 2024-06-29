part of '../../service.dart';

class UserRepository extends Repository implements UserInterface {
  UserRepository({required super.httpService});
  late Isar _isar;
  late UserModel user;
  String? _userId;
  CollectionSchema get shemaUser => UserModelSchema;

  Future<void> initialize({required bool internet, required bool loggined, required Isar isar}) async {
    _isar = isar;
    final userDB = await _isar.userModels.where().findFirst();
    if (userDB != null) {
      user = userDB;
      _userId = user.id.toString();
    }
  }

  @override
  Future<RepositoryStat> editUser({required String userId, String? name, String? name2, String? sex, String? phone, int? age}) async {
    final BaseResponse resp = await httpService.patch(
      editUserUri,
      data: {"userId": userId, "name": name, "sex": sex, "phone": phone, "age": age, "name2": name2},
    );
    return getStat(resp.message);
  }

  @override
  Future<UserModel?> get userGet async {
    final BaseResponse resp = await httpService.post(infoUserUri, data: {
      "userId": userId,
    });
    late UserModel user;
    if (resp.message == MESSAGE_SUCCESS) {
      user = UserModel.fromJson(resp.data);
      await _isar.writeTxn(() async => _isar.userModels.put(user));
    }
    return resp.message == MESSAGE_SUCCESS ? user : null;
  }

  @override
  Future<BaseResponse> signIn({required String email, required String password}) async {
    final BaseResponse resp = await httpService.post(signInUri, data: {
      "email": email,
      "password": password,
    });
    _userId = resp.data['userId'].toString();
    return resp;
  }

  @override
  Future<void> signOut() async {
    //  await _isar.writeTxn(() async {
    //       await _isar.userModels.filter().deleteAll();
    //     });
  }

  @override
  void deleteUser() {}

  @override
  void signUp({required String email, required String password}) {}

  @override
  bool get loggined => _userId != '0' && _userId != null;

  @override
  String get userId => _userId ?? '0';
}
