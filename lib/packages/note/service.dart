part of '../../service.dart';

class NoteService extends Repository implements NoteInterface {
  NoteService({required super.httpService});

  late Isar _isar;
  CollectionSchema get shemaNote => NoteModelSchema;
  CollectionSchema get shemaPage => PageModelSchema;

  Future<void> initialize({required bool internet, required bool loggined, required String userId, required Isar isar}) async {
    _isar = isar;
  }

  @override
  Future<void> editPage(PageModel model) async {
    await _isar.writeTxn(() async => await _isar.pageModels.put(model));
  }

  @override
  Future<List<NoteModel>> getNotesByPageId(Id pageId) async => await _isar.noteModels.filter().pageIdEqualTo(pageId).sortByPosition().findAll();

  @override
  Future<PageWithNotes> getPageById(Id pageId) async {
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

    final page = await _isar.pageModels.get(pageId);

    final notes = await getNotesByPageId(pageId);
    final childPages = await getChildPages(pageId);

    return PageWithNotes(
      page: page!,
      notes: notes,
      childPage: childPages,
    );
  }

  @override
  Future<List<PageWithNotes>> getPages() async {
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
  List<String> get suffics => ['empty', 'point', 'mark', 'tire'];

  @override
  Future<void> addPage(PageModel model) async {
    await _isar.writeTxn(() async {
      final maxPositionPage = await _isar.pageModels
          .filter()
          .parentIdEqualTo(
            model.parentId,
          )
          .sortByPositionDesc()
          .findFirst();
      model.position = (maxPositionPage?.position ?? 0) + 1;
      if (model.id == 0) {
        model.id = DateTime.now().millisecondsSinceEpoch;
      }
      await _isar.pageModels.put(model);
    });
    await addNote(NoteModel(
      id: DateTime.now().millisecondsSinceEpoch,
      text: '',
      position: 0, // Default position for a new note
      pageId: model.id,
      suffics: null,
      active: null,
      padding: null,
      markActive: null,
    ));
  }

  @override
  Future<void> addNote(NoteModel model) async {
    await _isar.writeTxn(() async {
      final notesToUpdate = await _isar.noteModels.filter().pageIdEqualTo(model.pageId).positionGreaterThan(model.position).findAll();
      for (var note in notesToUpdate) {
        note.position += 1;
      }

      await _isar.noteModels.putAll(notesToUpdate);

      if (model.id == 0) {
        model.id = DateTime.now().millisecondsSinceEpoch;
      }

      await _isar.noteModels.put(model);
    });
  }

  @override
  Future<void> addNoteAfterParent(NoteModel parentModel) async {
    await _isar.writeTxn(() async {
      final notesToUpdate = await _isar.noteModels.filter().pageIdEqualTo(parentModel.pageId).positionGreaterThan(parentModel.position).findAll();

      for (var note in notesToUpdate) {
        note.position += 1;
      }

      await _isar.noteModels.putAll(notesToUpdate);

      final newModel = NoteModel(
        id: DateTime.now().millisecondsSinceEpoch,
        text: '',
        suffics: parentModel.suffics,
        active: parentModel.active,
        padding: parentModel.padding,
        markActive: false,
        position: parentModel.position + 1,
        pageId: parentModel.pageId,
      );

      await _isar.noteModels.put(newModel);
    });
  }

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
  Future<void> deletePage(int pageId) async {
    await _isar.writeTxn(() async {
      final pageToDelete = await _isar.pageModels.get(pageId);
      if (pageToDelete != null) {
        final notesToDelete = await _isar.noteModels.filter().pageIdEqualTo(pageToDelete.id).findAll();
        for (var note in notesToDelete) {
          await _isar.noteModels.delete(note.id);
        }
        final positionToDelete = pageToDelete.position;
        await _isar.pageModels.delete(pageId);
        final pagesToUpdate = await _isar.pageModels.filter().parentIdEqualTo(pageToDelete.parentId).positionGreaterThan(positionToDelete).findAll();
        for (var page in pagesToUpdate) {
          page.position -= 1;
          await _isar.pageModels.put(page);
        }
      }
    });
  }

  @override
  Future<void> editNote(NoteModel model) async => await _isar.writeTxn(() async {
        final existingNote = await _isar.noteModels.get(model.id);
        if (existingNote == null) {
          return;
        }

        if (existingNote.position == model.position && existingNote.pageId == model.pageId) {
          await _isar.noteModels.put(model);
          return;
        }

        if (existingNote.pageId != model.pageId) {
          final oldPageNotes = await _isar.noteModels.filter().pageIdEqualTo(existingNote.pageId).positionGreaterThan(existingNote.position).findAll();

          for (var note in oldPageNotes) {
            note.position -= 1;
            await _isar.noteModels.put(note);
          }
        }
        if (existingNote.pageId == model.pageId) {
          final notesToUpdate = await _isar.noteModels.filter().pageIdEqualTo(model.pageId).findAll();

          if (existingNote.position < model.position) {
            for (var note in notesToUpdate) {
              if (note.position > existingNote.position && note.position <= model.position) {
                note.position -= 1;
                await _isar.noteModels.put(note);
              }
            }
          } else {
            for (var note in notesToUpdate) {
              if (note.position < existingNote.position && note.position >= model.position) {
                note.position += 1;
                await _isar.noteModels.put(note);
              }
            }
          }

          await _isar.noteModels.put(model);
          return;
        }

        if (existingNote.pageId != model.pageId) {
          final notesInNewPage = await _isar.noteModels.filter().pageIdEqualTo(model.pageId).findAll();

          for (var note in notesInNewPage) {
            if (note.position >= model.position) {
              note.position += 1;
              await _isar.noteModels.put(note);
            }
          }

          await _isar.noteModels.put(model);
        }
      });
}
