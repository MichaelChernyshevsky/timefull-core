import 'model.dart';

abstract class UserInterface {
  bool get loggined;
  String get userId;
  Future<UserModel?> get user;

  void signIn({required String email, required String password}) {}
  void signUp({required String email, required String password}) {}
  void signOut() {}

  void editUser({required String userId, required String name, required String sex, required String phone, required int age}) {}
  void deleteUser() {}
}
