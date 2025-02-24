// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

part 'model.g.dart';

typedef Styles = List<Style>;

@collection
class Style {
  Id id;
  String userId;
  String color;
  String icon;

  Style({
    required this.id,
    required this.userId,
    required this.color,
    required this.icon,
  });

  factory Style.fromJson(Map<String, Object?> json) {
    return Style(
      id: json['id'] as int,
      userId: json['userId'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> serialize() {
    return {
      'id': id,
      'userId': userId,
      'color': color,
      'icon': icon,
    };
  }
}
