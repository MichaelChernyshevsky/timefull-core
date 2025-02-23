import 'package:timefullcore/core.dart';
import 'package:timefullcore/helpers/api/models/filter_model.dart';
import 'package:timefullcore/helpers/common/repository.dart';
import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/sport/model.dart';
import 'package:timefullcore/packages/sport/repository.dart';

class SportService extends Repository {
  final SportRepository repository;
  late Isar _isar;
  CollectionSchema get shemaSport => SportModelSchema;

  SportService({required super.httpService}) : repository = SportRepository(httpService: httpService);

  Future<void> initialize({required CoreModel coreModel, required Isar isar}) async {
    _isar = isar;
  }

  void importdb(Map<String, dynamic> db) {}

  Map<String, dynamic> exportdb() {
    return {
      'economy': {},
      'sport': {},
      'notes': {},
      'tasks': {},
      'timer': {},
    };
  }

  Future<bool> add({
    required String title,
    required int distant,
    required String date,
    required CoreModel coreModel,
  }) async {
    if (coreModel.internet && coreModel.loggined) {
      final resp = await repository.add(userId: coreModel.userId, title: title, distant: distant, date: date);
    }
    await _isar.writeTxn(() async => _isar.sportModels.put(SportModel(date: date, distant: distant, id: DateTime.now().millisecondsSinceEpoch, title: title, userId: coreModel.userId)));
    return true;
  }

  Future<bool> delete({required int id, required CoreModel coreModel}) async {
    await _isar.writeTxn(() async => await _isar.sportModels.delete(id));
    return true;
  }

  Future<SportModels> get({required CoreModel coreModel, required FilterRequestModel? filter}) async {
    final models = await _isar.sportModels.where().findAll();
    return models;
  }
}
