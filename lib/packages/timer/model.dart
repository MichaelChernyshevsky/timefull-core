import 'package:isar/isar.dart';
part 'model.g.dart';

@collection
class TimerModel {
  final Id id;
  final String userId;
  int work;
  int relax;
  int workSave = 0;
  int relaxSave = 0;
  int timeWork;
  int timeRelax;
  int timeWorkSave = 0;
  int timeRelaxSave = 0;

  TimerModel({
    required this.id,
    required this.userId,
    required this.timeRelax,
    required this.timeWork,
    required this.work,
    required this.relax,
  });

  factory TimerModel.fromJson({required Map<String, dynamic> json}) {
    return TimerModel(
      id: json['id'],
      userId: json['userId'].toString(),
      timeRelax: json['stat']['timeRelax'],
      timeWork: json['stat']['timeWork'],
      work: json['history']['work'],
      relax: json['history']['relax'],
    );
  }
}
