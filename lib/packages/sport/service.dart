import 'package:timefullcore/core.dart';
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

  Future<SportModels> get({required CoreModel coreModel}) async {
    final resp = await repository.get(coreModel.userId);
    return (resp.data['sport'] as List).map((model) => SportModel.fromJson(model as Map<String, dynamic>)).toList();
  }
}
