import 'package:isar/isar.dart';
part 'model.g.dart';

@collection
class Packages {
  final String userId;
  Id id;

  bool economy;
  bool task;
  bool timer;

  Packages({
    required this.economy,
    required this.id,
    required this.task,
    required this.timer,
    required this.userId,
  });

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
        id: json["id"] as int,
        userId: json["userId"] as String,
        economy: json["economy"] as bool,
        task: json["tasks"] as bool,
        timer: json["timer"] as bool,
      );

  Map<String, dynamic> serialize() {
    return {
      'economy': economy,
      'tasks': task,
      'timer': timer,
    };
  }
}

class PackagesInfo {
  final List<PackageInfo> packagees;

  PackagesInfo({required this.packagees});

  factory PackagesInfo.fromJson(Map<String, dynamic> json) {
    final List<PackageInfo> packagees = [];
    for (final key in json.keys) {
      packagees.add(PackageInfo.fromJson(json[key] as Map<String, dynamic>));
    }
    return PackagesInfo(
      packagees: packagees,
    );
  }
}

class PackageInfo {
  final String title;
  final String description;

  PackageInfo({
    required this.title,
    required this.description,
  });

  factory PackageInfo.fromJson(Map<String, dynamic> json) {
    return PackageInfo(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
