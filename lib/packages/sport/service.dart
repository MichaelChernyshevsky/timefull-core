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
    final resp = await repository.add(userId: coreModel.userId, title: title, distant: distant, date: date);
    return true;
  }

  Future<bool> delete({required int id, required CoreModel coreModel}) async {
    final resp = await repository.delete(userId: coreModel.userId, id: id);
    return true;
  }

  Future<SportModels> get({required CoreModel coreModel, required FilterRequestModel filter}) async {
    final resp = await repository.get(userId: coreModel.userId, filter: filter);
    return (resp.message != 'unsuccess' && resp.data['sport'].length > 0) ? (resp.data['sport'] as List).map((model) => SportModel.fromJson(model as Map<String, dynamic>)).toList() : [];
  }
}
