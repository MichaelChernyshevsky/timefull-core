// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:timefullcore/core.dart';

part 'model.g.dart';

@collection
class PageModel {
  Id id;
  String title;
  int position;
  int? parentId;
  PageModel({
    required this.id,
    required this.title,
    required this.position,
    required this.parentId,
  });

  PageModel copyWith({
    Id? id,
    String? title,
    int? position,
    int? parentId,
  }) {
    return PageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      position: position ?? this.position,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'position': position,
      'parentId': parentId,
    };
  }

  String toJson() => json.encode(toMap());
}
