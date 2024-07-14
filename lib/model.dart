class CoreModel {
  bool loggined;
  bool internet;
  String userId;
  CoreModel({
    required this.loggined,
    required this.internet,
    required this.userId,
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
    );
  }
}
