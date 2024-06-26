import 'model.dart';

abstract class PackagesInterface {
  void getPackages({required String userId}) {}
  void changePackage({required PackageType type, required String userId}) {}
  void infoPackages() {}
}
