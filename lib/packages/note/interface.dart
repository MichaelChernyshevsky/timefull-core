import 'package:timefullcore/core.dart';
import 'package:timefullcore/packages/note/models/model.dart';
import 'package:timefullcore/packages/note/models/note_model/model.dart';
import 'package:timefullcore/packages/note/models/page_model/model.dart';

interface class NoteInterface {
  Future<List<PageWithNotes>> getPages() async => [];
  Future<PageWithNotes> getPageById(Id pageId) async => throw UnimplementedError();

  void addPage(PageModel model) {}
  void editPage(PageModel model) {}
  void deletePage(int id) {}

  void addNote(NoteModel model) {}
  Future<void> addNoteAfterParent(NoteModel parentModel) => throw UnimplementedError();
  Future<List<NoteModel>> getNotesByPageId(Id pageId) => throw UnimplementedError();
  void deleteNote(int id) {}
  void editNote(NoteModel model) {}

  List<String> get suffics => [];
}
