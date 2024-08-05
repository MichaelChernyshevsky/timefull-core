// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:timefullcore/core.dart';
import 'package:timefullcore/helpers/common/stateRepository.dart';
import 'package:timefullcore/packages/user/interface.dart';
import 'package:timefullcore/packages/user/uri.dart';

class UserRepository implements UserInterface {
  final HttpService httpService;
  final Isar isar;

  const UserRepository({
    required this.httpService,
    required this.isar,
  });

  Future<String> get userIdDB async {
    final userDB = await isar.userModels.where().findFirst();
    if (userDB != null) {
      return userDB.id.toString();
    }
    return "";
  }

  @override
  Future<RepositoryStat> editUser({required String userId, String? name, String? name2, String? sex, String? phone, int? age}) async {
    final BaseResponse resp = await httpService.patch(
      editUserUri,
      data: {
        "userId": userId,
        "name": name,
        "sex": sex,
        "phone": phone,
        "age": age,
        "name2": name2,
      },
    );
    return getStat(resp.message);
  }

  @override
  Future<UserModel?> userGet(String userId) async {
    final BaseResponse resp = await httpService.post(infoUserUri, data: {
      "userId": userId,
    });
    late UserModel user;
    if (resp.message == MESSAGE_SUCCESS) {
      user = UserModel.fromJson(resp.data);
      await isar.writeTxn(() async => isar.userModels.put(user));
    }
    return resp.message == MESSAGE_SUCCESS ? user : null;
  }

  @override
  Future<BaseResponse> signIn({required String email, required String password}) async {
    final BaseResponse resp = await httpService.post(signInUri, data: {
      "email": email,
      "password": password,
    });
    return resp;
  }

  @override
  Future<void> signOut() async {
    //  await isar.writeTxn(() async {
    //       await isar.userModels.filter().deleteAll();
    //     });
  }

  @override
  void deleteUser() {}

  @override
  Future<void> signUp({required String email, required String password}) async {}
}
