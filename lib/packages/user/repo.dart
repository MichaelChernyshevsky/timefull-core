part of '../../service.dart';

class UserRepository extends Repository implements UserInterface {
  UserRepository({required super.httpService});

  String? _userId;

  @override
  Future<RepositoryStat> editUser({required String userId, String? name, String? name2, String? sex, String? phone, int? age}) async {
    final BaseResponse resp = await httpService.patch(
      editUserUri,
      data: {"userId": userId, "name": name, "sex": sex, "phone": phone, "age": age, "name2": name2},
    );
    return getStat(resp.message);
  }

  @override
  Future<UserModel?> get user async {
    final BaseResponse resp = await httpService.post(infoUserUri, data: {
      "userId": userId,
    });
    return resp.message == MESSAGE_SUCCESS ? UserModel.fromJson(resp.data) : null;
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
  void signOut() {}

  @override
  void deleteUser() {}

  @override
  void signUp({required String email, required String password}) {}

  @override
  bool get loggined => _userId != '0';

  @override
  String get userId => _userId ?? '0';
}
