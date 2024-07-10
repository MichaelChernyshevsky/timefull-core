import 'package:timefullcore/core.dart';
import 'package:timefullcore/packages/note/models/model.dart';
import 'package:timefullcore/packages/note/models/note_model/model.dart';
import 'package:timefullcore/packages/note/models/page_model/model.dart';

part 'interface.dart';

class NoteRepository extends Repository implements NoteInterface {
  NoteRepository({required super.httpService});

  late Isar _isar;
  CollectionSchema get shemaNote => NoteModelSchema;
  CollectionSchema get shemaPage => PageModelSchema;

  Future<void> initialize({required bool internet, required bool loggined, required String userId, required Isar isar}) async {
    _isar = isar;
  }

  @override
  Future<void> deletePage(int pageId) async {
    await _isar.writeTxn(() async {
      // Найти PageModel по ID
      final pageToDelete = await _isar.pageModels.get(pageId);
      if (pageToDelete != null) {
        // Удалить все NoteModel, связанные с этим PageModel
        final notesToDelete = await _isar.noteModels.filter().pageIdEqualTo(pageToDelete.id).findAll();
        for (var note in notesToDelete) {
          await _isar.noteModels.delete(note.id);
        }

        // Сохранить позицию удаляемого PageModel
        final positionToDelete = pageToDelete.position;

        // Удалить PageModel
        await _isar.pageModels.delete(pageId);

        // Обновить позиции оставшихся PageModel
        final pagesToUpdate = await _isar.pageModels.filter().parentIdEqualTo(pageToDelete.parentId).positionGreaterThan(positionToDelete).findAll();

        for (var page in pagesToUpdate) {
          page.position -= 1;
          await _isar.pageModels.put(page); // Сохранить обновленный объект
        }
      }
    });
  }

  @override
  Future<void> editPage(PageModel model) async {
    await _isar.writeTxn(() async => await _isar.pageModels.put(model));
  }

  @override
  Future<List<PageWithNotes>> getPages() async {
    Future<List<NoteModel>> getNotesByPageId(Id pageId) async => await _isar.noteModels.filter().pageIdEqualTo(pageId).findAll();

    Future<List<PageWithNotes>> getChildPages(Id pageId) async {
      final list = (await _isar.pageModels.filter().parentIdEqualTo(pageId).findAll())
          .map((page) async => PageWithNotes(
                page: page,
                childPage: await getChildPages(page.id),
                notes: await getNotesByPageId(page.id),
              ))
          .toList();

      return await Future.wait(list);
    }

    final List<PageWithNotes> pages = (await _isar.pageModels.filter().parentIdIsNull().findAll())
        .map((page) => PageWithNotes(
              page: page,
              childPage: [],
              notes: [],
            ))
        .toList();

    if (pages.isNotEmpty) {
      for (int index = 0; index < pages.length; index++) {
        pages[index].notes = await getNotesByPageId(pages[index].page.id);
        pages[index].childPage = await getChildPages(pages[index].page.id);
      }
    }
    return pages;
  }

  @override
  List<String> get suffics => ['empty', 'point', 'suffics', 'mark', 'tire'];

  @override
  Future<void> addPage(PageModel model) async => await _isar.writeTxn(() async => await _isar.pageModels.put(model));

  @override
  Future<void> addNote(NoteModel model) async => await _isar.writeTxn(() async => await _isar.noteModels.put(model));

  @override
  Future<void> deleteNote(int noteId) async {
    await _isar.writeTxn(() async {
      final noteToDelete = await _isar.noteModels.get(noteId);
      if (noteToDelete != null) {
        final positionToDelete = noteToDelete.position;
        await _isar.noteModels.delete(noteId);
        final notesToUpdate = await _isar.noteModels
            .filter()
            .pageIdEqualTo(
              noteToDelete.pageId,
            )
            .positionGreaterThan(positionToDelete)
            .findAll();
        for (var note in notesToUpdate) {
          note.position -= 1;
          await _isar.noteModels.put(note);
        }
      }
    });
  }

  @override
  void editNote(NoteModel model) {}
}
