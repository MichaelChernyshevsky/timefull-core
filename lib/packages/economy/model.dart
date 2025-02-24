import 'package:isar/isar.dart';
part 'model.g.dart';

@collection
class EconomyModel {
  EconomyModel({
    required this.id,
    required this.title,
    required this.count,
    required this.income,
    this.description,
    this.type,
    this.date,
    this.styleId,
    required this.userId,
    required this.active,
  });
  Id id;
  String title;
  String count;
  String? description;
  String? type;
  int? date;
  bool income;
  bool active;
  String userId;
  String? styleId;

  factory EconomyModel.fromJson(Map<String, Object?> json) {
    return EconomyModel(
      id: json['id'] as int,
      title: json['title'] as String,
      count: json['count'].toString(),
      income: json['income'] as bool,
      description: json['description'] as String,
      type: json['type'] as String,
      styleId: json['styleId'] as String,
      date: json['date'] as int,
      userId: json['userId'] as String,
      active: true,
    );
  }

  Map<String, dynamic> serialize() {
    return {
      'id': id,
      'userId': userId,
      'income': income,
      'title': title,
      'type': type,
      'styleId': styleId,
      'description': description,
      'date': date,
      'count': count,
    };
  }
}
