import 'package:isar/isar.dart';
part 'model.g.dart';

@collection
class EconomyModel {
  EconomyModel(
      {required this.id,
      required this.title,
      required this.count,
      required this.income,
      required this.description,
      required this.date,
      required this.userId,
      required this.inDBl,
      required this.active});
  Id id;
  String title;
  String count;
  String? description;
  int date;
  bool income;
  bool active;
  String userId;
  bool inDBl;

  factory EconomyModel.fromJson(Map<String, Object?> json) {
    return EconomyModel(
      id: json['id'] as int,
      title: json['title'] as String,
      count: json['count'].toString(),
      income: json['income'] as bool,
      description: json['description'] as String,
      date: json['date'] as int,
      userId: json['userId'] as String,
      inDBl: true,
      active: true,
    );
  }

  Map<String, dynamic> serialize() {
    return {
      'id': id,
      'userId': userId,
      'income': income,
      'title': title,
      'description': description,
      'date': date,
      'count': count,
    };
  }
}
