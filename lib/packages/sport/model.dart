import 'package:timefullcore/core.dart';

part 'model.g.dart';

typedef SportModels = List<SportModel>;

@collection
class SportModel {
  String date;
  int distant;
  Id? id;
  String title;
  String userId;

  SportModel({
    required this.date,
    required this.distant,
    required this.id,
    required this.title,
    required this.userId,
  });

  // Метод для преобразования из JSON в объект SportModel
  factory SportModel.fromJson(Map<String, dynamic> json) {
    return SportModel(
      date: json['date'],
      distant: json['distant'],
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }

  // Метод для преобразования объекта SportModel в JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'distant': distant,
      'id': id,
      'title': title,
      'userId': userId,
    };
  }
}
