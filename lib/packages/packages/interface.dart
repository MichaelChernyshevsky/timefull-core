import 'model.dart';

abstract class PackagesInterface {
  void getPackagesApi({required String userId}) {}
  void changePackageApi({required String type, required String userId}) {}
  void infoPackagesApi() {}
}
