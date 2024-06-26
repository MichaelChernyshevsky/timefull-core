import 'package:core/core.dart';

String fromEnumToString(PackageType type) {
  switch (type) {
    case PackageType.economy:
      return 'economy';
    case PackageType.timer:
      return 'timer';
    case PackageType.task:
      return 'task';
  }
}
