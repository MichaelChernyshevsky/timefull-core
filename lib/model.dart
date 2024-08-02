// ignore_for_file: public_member_api_docs, sort_constructors_first
class CoreModel {
  bool loggined;
  bool internet;
  String userId;
  bool isWeb;
  CoreModel({
    required this.loggined,
    required this.internet,
    required this.userId,
    required this.isWeb,
  });

  CoreModel copyWith({
    bool? loggined,
    bool? internet,
    String? userId,
  }) {
    return CoreModel(
      loggined: loggined ?? this.loggined,
      internet: internet ?? this.internet,
      userId: userId ?? this.userId,
      isWeb: isWeb,
    );
  }
}
