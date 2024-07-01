part of '../../service.dart';

class PackagesRepository extends Repository implements PackagesInterface {
  PackagesRepository({required super.httpService});

  CollectionSchema get shemaPackages => PackagesSchema;
  late Isar _isar;
  Packages? packages;

  Future<void> initialize({required bool internet, required bool loggined, required String userId, required Isar isar}) async {
    _isar = isar;
    final packageDB = await _isar.packages.where().findFirst();
    if (packageDB == null) {
      final form = Packages(economy: false, id: 1, task: false, timer: false, userId: userId);
      await _isar.writeTxn(() async => _isar.packages.put(form));
      packages = form;
    } else {
      packages = packageDB;
    }
  }

  @override
  Future<bool> changePackageApi({required PackageType type, required String userId}) async {
    final BaseResponse resp = await httpService.post(
      changePackageUri,
      data: {"userId": userId, "package": fromEnumToString(type)},
    );
    return resp.message == MESSAGE_SUCCESS;
  }

  @override
  Future<Packages> getPackagesApi({required String userId}) async {
    final BaseResponse resp = await httpService.post(
      getPackageUri,
      data: {"userId": userId},
    );
    return Packages.fromJson(resp.data);
  }

  @override
  Future<PackagesInfo> infoPackagesApi() async {
    final BaseResponse resp = await httpService.post(infoPackageUri);
    return PackagesInfo.fromJson(resp.data);
  }

  Future<bool> changePackage({required String userId, required PackageType type, required bool interner}) async {
    if (interner) {
      final packagesApi = await changePackageApi(userId: userId, type: type);
      if (packagesApi != true) {
        return false;
      }
    }

    switch (type) {
      case PackageType.economy:
        packages!.economy = !packages!.economy;
      case PackageType.task:
        packages!.task = !packages!.task;
      case PackageType.timer:
        packages!.timer = !packages!.timer;
    }
    await _isar.packages.where().deleteAll();
    await _isar.writeTxn(() async => _isar.packages.put(packages!));
    return true;
  }

  Future<Packages> getPackages({required String userId, required bool interner}) async {
    if (interner) {
      final packagesApi = await getPackagesApi(userId: userId);
      await _isar.packages.where().deleteAll();
      await _isar.writeTxn(() async => _isar.packages.put(packagesApi));
      return packagesApi;
    } else {
      return packages!;
    }
  }
}
