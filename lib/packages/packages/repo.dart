part of '../../service.dart';

class PackagesRepository extends Repository implements PackagesInterface {
  PackagesRepository({required super.httpService});

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
