// ignore_for_file: depend_on_referenced_packages

part of '../../service.dart';

class EconomyRepository extends Repository implements EconomyInterface {
  EconomyRepository({required super.httpService});
  late Isar _isar;
  CollectionSchema get shemaEconomy => EconomyModelSchema;

  Future<void> initialize({required bool internet, required bool loggined, required String userId, required Isar isar}) async {
    _isar = isar;
    if (internet && loggined) await refresh(userId: userId);
  }

  @override
  Future<RepositoryStat> addEconomyApi({
    required String title,
    required String description,
    required int count,
    required int date,
    required int income,
    required String userId,
  }) async {
    final BaseResponse resp = await httpService.post(economyAdd, data: {
      "userId": userId,
      "count": count,
      "date": date,
      "income": income == true ? 1 : false,
      "title": title,
      "description": description,
    });
    print(resp.message);
    return getStat(resp.message);
  }

  @override
  Future<RepositoryStat> deleteEconomyApi({required String id, required String userId}) async {
    final BaseResponse resp = await httpService.delete(economyDelete, data: {"id": id, 'userId': userId});
    return getStat(resp.message);
  }

  @override
  Future<List<EconomyModel>> getEconomyApi({required String userId}) async {
    final BaseResponse resp = await httpService.post(economyGet, data: {"userId": userId});
    final List<EconomyModel> models = [];
    for (final element in resp.data['data']) {
      models.add(EconomyModel.fromJson(element));
    }
    return models;
  }

  Future<bool> refresh({required String userId}) async {
    try {
      final list = await _isar.economyModels.filter().inDBlEqualTo(false).findAll();
      if (list.isNotEmpty) {
        for (final EconomyModel element in list) {
          await addEconomy(
            count: int.parse(element.count),
            title: element.title,
            description: element.description ?? '',
            date: element.date,
            income: element.income,
            userId: userId,
            loggined: true,
            internet: true,
          );
        }
        await _isar.writeTxn(() async {
          await _isar.economyModels.filter().inDBlEqualTo(false).deleteAll();
        });
      }
      await _isar.economyModels.filter().inDBlEqualTo(true).deleteAll();

      final elements = await getEconomyApi(userId: userId);
      await _isar.writeTxn(() async {
        for (final element in elements) {
          final contain = await _isar.economyModels.filter().idEqualTo(element.id).findAll();
          if (contain.isEmpty) {
            await _isar.economyModels.put(element);
          }
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  void statEconomyApi() {}

  Future<RepositoryStat> addEconomy({
    required String title,
    required String description,
    required int count,
    required int date,
    required bool income,
    required String userId,
    required bool loggined,
    required bool internet,
  }) async {
    Future<void> save() async {
      await _isar.writeTxn(() async {
        final newEconomy = EconomyModel(
          id: Random().nextInt(1000000000),
          title: title,
          count: count.toString(),
          income: true,
          description: "This is an example",
          date: DateTime.now().millisecondsSinceEpoch,
          userId: userId,
          inDBl: false,
          active: true,
        );

        await _isar.economyModels.put(newEconomy);
      });
    }

    try {
      if (internet && loggined) {
        final state = (await addEconomyApi(
              count: count,
              title: title,
              description: description,
              date: date,
              income: income == true ? 1 : 0,
              userId: userId,
            ) ==
            RepositoryStat.resp_success);
        if (state) {
          await save();
          return RepositoryStat.sended;
        }
      }
      await save();
      return RepositoryStat.saved;
    } catch (_) {
      return RepositoryStat.error;
    }
  }

  Future<RepositoryStat> deleteEconomy({required int id, required String userId, required bool loggined, required bool internet}) async {
    try {
      if (internet && loggined) {
        await deleteEconomyApi(id: id.toString(), userId: userId);
        await _isar.writeTxn(() async => await _isar.economyModels.delete(id));
      } else {
        final List<EconomyModel> elements = await _isar.economyModels.where().idEqualTo(id).findAll();
        await _isar.writeTxn(() async => await _isar.economyModels.where().idEqualTo(id).deleteAll());
        if (elements.isNotEmpty) {
          elements[0].active = false;
          await _isar.writeTxn(() async => await _isar.economyModels.put(elements[0]));
        }
      }
      return RepositoryStat.deleted;
    } catch (_) {
      return RepositoryStat.error;
    }
  }

  Future<List<EconomyModel>> getEconomy({required String userId, required bool loggined, required bool internet}) async {
    if (internet && loggined) {
      await refresh(userId: userId);
    }
    return await _isar.economyModels.where().findAll();
  }
}
