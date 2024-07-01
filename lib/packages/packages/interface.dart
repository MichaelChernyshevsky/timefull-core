import 'model.dart';

abstract class PackagesInterface {
  void getPackagesApi({required String userId}) {}
  void changePackageApi({required PackageType type, required String userId}) {}
  void infoPackagesApi() {}
}
