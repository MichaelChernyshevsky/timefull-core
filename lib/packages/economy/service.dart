// economy_repository.dart

import 'package:timefullcore/core.dart';
import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/economy/repository.dart';

class EconomyService extends Repository implements EconomyInterface {
  final EconomyRepository repository;
  late Isar _isar;

  CollectionSchema get shemaEconomy => EconomyModelSchema;

  EconomyService({required super.httpService}) : repository = EconomyRepository(httpService: httpService);

  Future<void> initialize({required CoreModel coreModel, required Isar isar}) async {
    _isar = isar;
    final packageDB = await _isar.economyModels.where().findFirst();
    if (packageDB == null) {
      final form = EconomyModel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: "Initial",
        count: "0",
        income: true,
        description: "Initial economy model",
        date: DateTime.now().millisecondsSinceEpoch,
        userId: coreModel.userId,
        active: true,
      );
      await _isar.writeTxn(() async => _isar.economyModels.put(form));
    }
    if (coreModel.internet && coreModel.loggined) {
      await refresh(coreModel: coreModel);
    }
  }

  Future<bool> refresh({required CoreModel coreModel}) async {
    // try {
    //   final list = await _isar.economyModels.filter().findAll();
    //   if (list.isNotEmpty) {
    //     for (final EconomyModel element in list) {
    //       await addEconomy(
    //         count: int.parse(element.count),
    //         title: element.title,
    //         description: element.description ?? '',
    //         date: element.date,
    //         income: element.income,
    //         coreModel: coreModel,
    //       );
    //     }
    //     await _isar.writeTxn(() async {
    //       await _isar.economyModels.filter().inDBlEqualTo(false).deleteAll();
    //     });
    //   }
    //   await _isar.economyModels.filter().inDBlEqualTo(true).deleteAll();

    //   final elements = await repository.getEconomyApi(userId: coreModel.userId);
    //   await _isar.writeTxn(() async {
    //     for (final element in elements) {
    //       final contain = await _isar.economyModels.filter().idEqualTo(element.id).findAll();
    //       if (contain.isEmpty) {
    //         await _isar.economyModels.put(element);
    //       }
    //     }
    //   });
    //   return true;
    // } catch (_) {
    //   return false;
    // }
    return true;
  }

  Future<RepositoryStat> addEconomy({
    required String title,
    required String type,
    required String description,
    required int count,
    required bool income,
    required CoreModel coreModel,
    int? date,
  }) async {
    Future<void> save() async {
      await _isar.writeTxn(() async {
        final newEconomy = EconomyModel(
          id: DateTime.now().millisecondsSinceEpoch,
          title: title,
          type: type,
          count: count.toString(),
          income: true,
          description: "This is an example",
          date: date ?? DateTime.now().millisecondsSinceEpoch,
          userId: coreModel.userId,
          active: true,
        );

        await _isar.economyModels.put(newEconomy);
      });
    }

    try {
      if (coreModel.internet && coreModel.loggined) {
        final state = (await repository.addEconomyApi(
              count: count,
              title: title,
              description: description,
              date: date ?? DateTime.now().millisecondsSinceEpoch,
              income: income == true ? 1 : 0,
              userId: coreModel.userId,
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

  Future<RepositoryStat> deleteEconomy({required int id, required CoreModel coreModel}) async {
    try {
      if (coreModel.internet && coreModel.loggined) {
        await repository.deleteEconomyApi(id: id.toString(), userId: coreModel.userId);
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

  Future<Map<String, int>> getStat() async {
    final Map<String, int> stat = {};
    final models = await _isar.economyModels.where().findAll();

    for (final model in models) {
      if (model.type != null) {
        String type = model.type!;
        type = type == "" ? "other" : type;
        final count = int.tryParse(model.count) ?? 0;

        if (stat.containsKey(type)) {
          if (model.income) {
            stat[type] = stat[type]! + count;
          } else {
            stat[type] = stat[type]! - count;
          }
        } else {
          stat[type] = count;
        }
      }
    }

    return stat;
  }

  Future<List<EconomyModel>> getEconomy({required CoreModel coreModel, int? from, int? to}) async {
    if (coreModel.internet && coreModel.loggined) {
      await refresh(coreModel: coreModel);
    }
    if (from == null && to == null) {
      return await _isar.economyModels.where().findAll();
    } else {
      return _isar.economyModels
          .filter()
          .dateBetween(
            from,
            to,
            includeLower: true,
            includeUpper: true,
          )
          .findAll();
    }
  }

  Future<bool> wipeEconomy({required String userId, required bool loggined, required bool internet}) async {
    try {
      await _isar.writeTxn(() async => await _isar.economyModels.clear());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<String>> get listTypes async => repository.listTypes;
}
