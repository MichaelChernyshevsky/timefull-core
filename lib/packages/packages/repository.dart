// packages_service.dart

import 'package:timefullcore/helpers/common/repository.dart';
import 'package:timefullcore/helpers/common/stateRepository.dart';
import 'package:timefullcore/model.dart';
import 'package:timefullcore/packages/packages/model.dart';
import 'package:timefullcore/packages/packages/uri.dart';

class PackagesRepository {
  final HttpService httpService;

  PackagesRepository({required this.httpService});

  Future<bool> changePackageApi({required String type, required CoreModel coreModel}) async {
    final BaseResponse resp = await httpService.post(
      changePackageUri,
      data: {"userId": coreModel.userId, "package": type},
    );

    return resp.message == MESSAGE_SUCCESS;
  }

  Future<Packages> getPackagesApi({required CoreModel coreModel}) async {
    final BaseResponse resp = await httpService.post(
      getPackageUri,
      data: {"userId": coreModel.userId},
    );
    return Packages.fromJson(resp.data);
  }

  Future<PackagesInfo> infoPackagesApi({required CoreModel coreModel}) async {
    final BaseResponse resp = await httpService.post(infoPackageUri);
    return PackagesInfo.fromJson(resp.data);
  }
}
