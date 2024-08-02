import 'dart:io';
import 'package:timefullcore/core.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:timefullcore/packages/note/models/note_model/model.dart';
import 'package:timefullcore/packages/note/models/page_model/model.dart';

Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

List<Map<String, dynamic>> splitOnLevels(Map<String, dynamic> data) {
  final levels = [data];
  final childPages = data["childPage"] as List?;

  if (childPages != null) {
    for (var childPageData in childPages) {
      levels.addAll(splitOnLevels(childPageData));
    }
  }

  return levels;
}

void main() {
  // late UserRepository userRepo;
  late NoteService noteRepo;
  late Isar isar;
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final httpService = DioHttpService(baseUrl: 'http://127.0.0.1:5000');
    // userRepo = UserRepository(httpService: httpService);
    noteRepo = NoteService(httpService: httpService);

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open(
      [
        noteRepo.shemaNote,
        noteRepo.shemaPage,
      ],
      directory: await testDirectory,
    );
  });

  tearDownAll(() async {
    await isar.close();
  });

  bool loggined = false;
  String userId0 = '0';
  String userId = '0';
  bool internet = false;

  test(
    "Note -  initialize",
    () async => await noteRepo.initialize(
      internet: internet,
      loggined: loggined,
      userId: userId0,
      isar: isar,
    ),
  );

  // group('Set user', () {
  //   test("- signin", () async {
  //     const String email = 'admin@server.com';
  //     const String password = 'Test12345';
  //     await userRepo.signIn(email: email, password: password);
  //     expect(userRepo.loggined, true);
  //   });
  //   test("- user", () async {
  //     final user = userRepo.user;
  //     userId = user.id.toString();
  //   });
  // });

  group('Note Repository', () {
    test("-  get empty", () async {
      print(noteRepo.suffics);
    });
  });

  group('Page isar without login', () {
    test("-  get empty", () async {
      expect((await noteRepo.getPages()).length, 0);
    });

    test("-  add page 1", () async {
      await noteRepo.addPage(PageModel(id: 1, title: 'title', position: 0, parentId: null));
      expect((await noteRepo.getPages()).isEmpty, false);
    });

    test("-  add page child", () async {
      await noteRepo.addPage(PageModel(id: 2, title: 'title', position: 0, parentId: 1));
      await noteRepo.addPage(PageModel(id: 3, title: 'title', position: 0, parentId: 2));
      final level_1 = (await noteRepo.getPages()).length;
      final level_2 = (await noteRepo.getPages())[0].childPage.length;
      final level_3 = (await noteRepo.getPages())[0].childPage[0].childPage.length;

      print((await noteRepo.getPages()).map((element) => element.toJson()));
      expect((level_1 == 1) && (level_2 == 1) && (level_3 == 1), true);
    });

    //   test("-  delete page 1", () async {
    //     await noteRepo.deletePage(2);
    //     expect((await noteRepo.getPages())[0].childPage.isEmpty, true);
    //   });
    // });

    // group('Note isar without login', () {
    //   test("-  get empty", () async {
    //     expect((await noteRepo.getPages())[0].notes.isEmpty, true);
    //   });

    //   test("-  add note ", () async {
    //     await noteRepo.addNote(NoteModel(id: 1, text: 'text', suffics: '', position: 1, pageId: 1));
    //     expect((await noteRepo.getPages())[0].notes.isEmpty, false);
    //   });

    //   test("-  add note ", () async {
    //     await noteRepo.addNote(NoteModel(id: 2, text: 'text', suffics: '', position: 2, pageId: 1));
    //     expect((await noteRepo.getPages())[0].notes.isEmpty, false);
    //   });
  });
}
