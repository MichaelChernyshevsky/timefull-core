import 'package:timefullcore/core.dart';
import 'package:timefullcore/helpers/api/models/filter_model.dart';
import 'package:timefullcore/helpers/common/repository.dart';
import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/sport/model.dart';
import 'package:timefullcore/packages/sport/repository.dart';

class SportService extends Repository {
  final SportRepository repository;
  late Isar _isar;
  CollectionSchema get shema => SportModelSchema;

  SportService({required super.httpService}) : repository = SportRepository(httpService: httpService);

  Future<void> initialize({required CoreModel coreModel, required Isar isar}) async {
    _isar = isar;
  }

  Future<void> importdb(Map<String, dynamic> db) async {
    await _isar.writeTxn(() async => await _isar.sportModels.where().deleteAll());
    for (final key in db.keys) {
      await add(
        userId: db[key]["userId"],
        id: db[key]["id"],
        title: db[key]["title"],
        distant: db[key]["distant"],
        date: db[key]["date"],
      );
    }
  }

  Future<Map<String, dynamic>> exportdb() async {
    final SportModels models = await get(
      coreModel: CoreModel(loggined: false, internet: false, userId: '', isWeb: false),
      filter: null,
    );

    Map<String, dynamic> db = {};

    for (final model in models) {
      db[model.id.toString()] = {
        'date': model.date,
        'distant': model.distant,
        'id': model.id,
        'title': model.title,
        'userId': model.userId,
      };
    }

    return db;
  }

  Future<bool> add({
    required String title,
    required int distant,
    required String date,
    CoreModel? coreModel,
    String? userId,
    int? id,
  }) async {
    if (coreModel != null && coreModel.internet && coreModel.loggined) {
      final resp = await repository.add(userId: coreModel.userId, title: title, distant: distant, date: date);
    }
    await _isar.writeTxn(() async => _isar.sportModels.put(SportModel(
          date: date,
          distant: distant,
          id: id ?? DateTime.now().millisecondsSinceEpoch,
          title: title,
          userId: userId ?? coreModel!.userId,
        )));
    return true;
  }

  Future<bool> delete({required int id, required CoreModel coreModel}) async {
    await _isar.writeTxn(() async => await _isar.sportModels.delete(id));
    return true;
  }

  Future<SportModels> get({required CoreModel coreModel, FilterRequestModel? filter}) async {
    final models = await _isar.sportModels.where().findAll();
    return models;
  }
}
