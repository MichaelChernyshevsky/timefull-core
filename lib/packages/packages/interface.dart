import 'package:timefullcore/core.dart';
import 'package:timefullcore/model.dart';

import 'model.dart';

abstract class PackagesInterface {
  void initialize({required CoreModel coreModel, required Isar isar}) {}

  Future<bool> changePackage({
    required String type,
    required CoreModel coreModel,
  }) async =>
      throw UnimplementedError();

  Future<Packages> getPackages({
    required CoreModel coreModel,
  }) async =>
      throw UnimplementedError();
}
