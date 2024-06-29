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
      await _isar.writeTxn(() async => _isar.packages.put(Packages(economy: false, id: 1, tasks: false, timer: false, userId: userId)));
    } else {
      packages = packageDB;
    }
  }

  @override
  Future<bool> changePackage({required PackageType type, required String userId}) async {
    final BaseResponse resp = await httpService.post(
      changePackageUri,
      data: {"userId": userId, "package": fromEnumToString(type)},
    );
    return resp.message == MESSAGE_SUCCESS;
  }

  @override
  Future<Packages> getPackages({required String userId}) async {
    final BaseResponse resp = await httpService.post(
      getPackageUri,
      data: {"userId": userId},
    );
    return Packages.fromJson(resp.data);
  }

  @override
  Future<PackagesInfo> infoPackages() async {
    final BaseResponse resp = await httpService.post(infoPackageUri);
    return PackagesInfo.fromJson(resp.data);
  }
}
