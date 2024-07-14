// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:timefullcore/core.dart';

part 'model.g.dart';

class TasksModels {
  final List<TaskModel> tasks;
  TasksModels(this.tasks);

  factory TasksModels.fromJson(Map<String, dynamic> json) {
    final List<TaskModel> tasks = [];
    for (final task in json['data'] as List<dynamic>) {
      tasks.add(TaskModel.fromJson(task));
    }

    return TasksModels(tasks);
  }
}

@collection
class TaskModel {
  final Id id;

  int date;
  String description;
  String title;
  String userId;
  int countOnTask;
  int countOnTaskDone;
  int countDoneTotal;
  int countUnDoneTotal;

  TaskModel({
    required this.id,
    required this.date,
    required this.description,
    required this.title,
    required this.userId,
    required this.countOnTask,
    required this.countOnTaskDone,
    required this.countDoneTotal,
    required this.countUnDoneTotal,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        countOnTask: json["countOnTask"] as int,
        date: json["date"] as int,
        description: json["description"] as String,
        title: json["title"] as String,
        userId: json["userId"] as String,
        countDoneTotal: json["countDone"] as int,
        countUnDoneTotal: json["countUnDone"] as int,
        countOnTaskDone: json["countOnTaskDone"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "countOnTask": countOnTask,
        "date": date,
        "description": description,
        "title": title,
        "userId": userId,
        "countDoneTotal": countDoneTotal,
        "countUnDoneTotal": countUnDoneTotal,
      };
}
