import 'package:timefullcore/core.dart';
import 'package:timefullcore/helpers/common/repository.dart';
import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/sport/model.dart';
import 'package:timefullcore/packages/styles/model.dart';
import 'package:timefullcore/service.dart';

class StyleService extends Repository {
  late Isar _isar;

  CollectionSchema get shema => StyleSchema;
  StyleService({required super.httpService});

  Future<void> initialize({required CoreModel coreModel, required Isar isar}) async {
    _isar = isar;
  }

  Future<bool> add({
    required String icon,
    required String color,
    CoreModel? coreModel,
    String? userId,
    int? id,
  }) async {
    await _isar.writeTxn(
      () async => _isar.styles.put(
        Style(
          id: id ?? DateTime.now().millisecondsSinceEpoch,
          userId: userId ?? coreModel!.userId,
          color: color,
          icon: icon,
        ),
      ),
    );
    return true;
  }

  Future<bool> delete({required int id, required CoreModel coreModel}) async {
    await _isar.writeTxn(() async => await _isar.styles.delete(id));
    return true;
  }

  Future<Styles> get({required CoreModel coreModel}) async {
    if (coreModel.internet && coreModel.loggined) {
      // await refresh(coreModel: coreModel);
    }

    return await _isar.styles.where().findAll();
  }

  Future<void> importdb(Map<String, dynamic> db) async {
    await _isar.writeTxn(() async => await _isar.styles.where().deleteAll());
    for (final key in db.keys) {
      await add(
        icon: db[key]["icon"],
        color: db[key]["icon"],
        userId: db[key]["userId"],
        id: db[key]["id"],
      );
    }
  }

  Future<Map<String, dynamic>> exportdb() async {
    final Styles models = await get(coreModel: CoreModel(loggined: false, internet: false, userId: '', isWeb: false));

    Map<String, dynamic> db = {};

    for (final model in models) {
      db[model.id.toString()] = {
        'id': model.id,
        'userId': model.userId,
        'color': model.color,
        'icon': model.icon,
      };
    }

    return db;
  }
}
