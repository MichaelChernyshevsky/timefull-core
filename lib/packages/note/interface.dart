part of 'repo.dart';

interface class NoteInterface {
  Future<List> getPages() async => [];
  void addPage(PageModel model) {}
  void editPage(PageModel model) {}
  void deletePage(int id) {}

  void addNote(NoteModel model) {}
  void deleteNote(int id) {}
  void editNote(NoteModel model) {}

  List<String> get suffics => [];
}
