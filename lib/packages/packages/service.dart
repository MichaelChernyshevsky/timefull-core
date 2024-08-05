// packages_repository.dart

import 'package:isar/isar.dart';
import 'package:timefullcore/helpers/common/repository.dart';
import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/packages/interface.dart';
import 'package:timefullcore/packages/packages/model.dart';
import 'package:timefullcore/packages/packages/repository.dart';

class PackagesService extends Repository implements PackagesInterface {
  final PackagesRepository repository;

  PackagesService({required super.httpService}) : repository = PackagesRepository(httpService: httpService);

  CollectionSchema get shemaPackages => PackagesSchema;
  late Isar _isar;
  Packages? packages;

  @override
  Future<void> initialize({required CoreModel coreModel, required Isar isar}) async {
    _isar = isar;
    final packageDB = await _isar.packages.where().findFirst();
    if (packageDB == null) {
      final form = Packages(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: coreModel.userId,
        task: false,
        timer: false,
        economy: false,
        note: false,
      );
      await _isar.writeTxn(() async => _isar.packages.put(form));
      packages = form;
    } else {
      packages = packageDB;
    }
  }

  @override
  Future<bool> changePackage({required String type, required CoreModel coreModel}) async {
    if (coreModel.internet) {
      final packagesApi = await repository.changePackageApi(coreModel: coreModel, type: type);
      if (packagesApi != true) {
        return false;
      }
    }

    if (type == 'economy') {
      packages!.economy = !packages!.economy;
    } else if (type == 'timer') {
      packages!.timer = !packages!.timer;
    } else if (type == 'task') {
      packages!.task = !packages!.task;
    } else if (type == 'note') {
      packages!.note = !packages!.note;
    }

    await _isar.writeTxn(() async => await _isar.packages.clear());
    await _isar.writeTxn(() async => _isar.packages.put(packages!));
    return true;
  }

  @override
  Future<Packages> getPackages({required CoreModel coreModel}) async {
    if (coreModel.internet) {
      final packagesApi = await repository.getPackagesApi(coreModel: coreModel);
      // await _isar.packages.where().deleteAll();
      // await _isar.writeTxn(() async => _isar.packages.put(packagesApi));
      return packagesApi;
    } else {
      return packages!;
    }
  }

  Future<PackagesInfo?> infoPackages({
    required CoreModel coreModel,
  }) async {
    if (coreModel.internet) {
      return await repository.infoPackagesApi(coreModel: coreModel);
    } else {
      return null;
    }
  }
}
