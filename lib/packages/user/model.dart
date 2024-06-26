import 'dart:ffi';

class UserModel {
  final bool? admin;
  final bool? creator;
  final String email;
  final String id;
  final UserInfo? info;
  final int packagesId;
  final String password; // **Never store passwords in plain text**
  final String? phone;
  final bool? subscribed;

  UserModel({
    this.admin,
    this.creator,
    required this.email,
    required this.id,
    this.info,
    required this.packagesId,
    required this.password, // **Never store passwords in plain text**
    this.phone,
    this.subscribed,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        admin: json["admin"] ?? false,
        creator: json["creator"] ?? false,
        email: json["email"] as String,
        id: json["id"].toString(),
        info: json["info"] != null ? UserInfo.fromJson(json["info"]) : null,
        packagesId: json["packagesId"] as int,
        password: json["password"] as String, // **Never store passwords in plain text**
        phone: json["phone"] as String?,
        subscribed: json["subscribed"] as bool?,
      );
}

class UserInfo {
  final int? age;
  final int id;
  final String? name;
  final String? name2;
  final String? sex;
  final String userId;

  UserInfo({
    this.age,
    required this.id,
    this.name,
    this.name2,
    this.sex,
    required this.userId,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        age: json["age"] as int?,
        id: json["id"] as int,
        name: json["name"] as String?,
        name2: json["name2"] as String?,
        sex: json["sex"] as String?,
        userId: json["userId"].toString(),
      );
}
