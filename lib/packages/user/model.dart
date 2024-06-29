import 'package:isar/isar.dart';
part 'model.g.dart';

@collection
class UserModel {
  final Id id;
  final bool? admin;
  final bool? creator;
  final String email;
  final int packagesId;
  final String password;
  final String? phone;
  final bool? subscribed;
  final int? age;
  final String? name;
  final String? name2;
  final String? sex;
  final String userId;

  UserModel({
    this.admin,
    this.creator,
    required this.email,
    required this.id,
    required this.packagesId,
    required this.password,
    this.phone,
    this.subscribed,
    this.age,
    this.name,
    this.name2,
    this.sex,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        admin: json["admin"] ?? false,
        creator: json["creator"] ?? false,
        email: json["email"] as String,
        id: json["id"],
        packagesId: json["packagesId"] as int,
        password: json["password"] as String,
        phone: json["phone"] as String?,
        subscribed: json["subscribed"] as bool?,
        age: json["info"]["age"] as int?,
        name: json["info"]["name"] as String?,
        name2: json["info"]["name2"] as String?,
        sex: json["info"]["sex"] as String?,
        userId: json["info"]["userId"].toString(),
      );
}
