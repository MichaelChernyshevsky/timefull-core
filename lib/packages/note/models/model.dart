// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:timefullcore/packages/note/models/note_model/model.dart';
import 'package:timefullcore/packages/note/models/page_model/model.dart';

class PageWithNotes {
  PageModel page;
  List<PageWithNotes> childPage;
  List<NoteModel> notes;

  PageWithNotes({
    required this.page,
    required this.childPage,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page.toMap(),
      'childPage': childPage.map((x) {
        return x.toMap();
      }).toList(growable: false),
      'notes': notes.map((x) {
        return x.toMap();
      }).toList(growable: false),
    };
  }

  String toJson() => json.encode(toMap());
}
