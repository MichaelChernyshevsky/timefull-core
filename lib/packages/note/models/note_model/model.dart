// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:timefullcore/core.dart';

part 'model.g.dart';

@collection
class NoteModel {
  Id id;
  String text;
  String? suffics;
  bool? active;
  int? padding;
  bool? markActive;

  int position;
  int pageId;

  NoteModel({
    required this.id,
    required this.text,
    required this.suffics,
    required this.position,
    required this.pageId,
    this.active,
    this.padding,
    this.markActive,
  });

  NoteModel copyWith({
    int? id,
    String? text,
    String? suffics,
    bool? active,
    int? padding,
    bool? markActive,
    int? position,
    int? pageId,
  }) {
    return NoteModel(
      id: id ?? this.id,
      text: text ?? this.text,
      suffics: suffics ?? this.suffics,
      active: active ?? this.active,
      padding: padding ?? this.padding,
      markActive: markActive ?? this.markActive,
      position: position ?? this.position,
      pageId: pageId ?? this.pageId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'suffics': suffics,
      'active': active,
      'padding': padding,
      'markActive': markActive,
      'position': position,
      'pageId': pageId,
    };
  }

  String toJson() => json.encode(toMap());
}
