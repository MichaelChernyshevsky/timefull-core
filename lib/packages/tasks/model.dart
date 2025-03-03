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
  Id? id;
  String? userId;
  String description;
  String title;
  int countOnTask;
  int countOnTaskDone;
  int countDoneTotal;
  int countUnDoneTotal;
  int? date;

  TaskModel({
    this.id,
    this.date,
    this.userId,
    required this.description,
    required this.title,
    required this.countOnTask,
    required this.countOnTaskDone,
    required this.countDoneTotal,
    required this.countUnDoneTotal,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        countOnTask: json["countOnTask"],
        date: int.parse(json["date"]),
        description: json["description"] as String,
        title: json["title"] as String,
        userId: json["userId"] as String,
        countDoneTotal: int.parse(json["countDone"] ?? '0'),
        countUnDoneTotal: int.parse(json["countUnDone"] ?? '0'),
        countOnTaskDone: int.parse(json["countOnTaskDone"] ?? '0'),
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

  TaskModel copyWith({
    Id? id,
    int? date,
    String? userId,
    String? description,
    String? title,
    int? countOnTask,
    int? countOnTaskDone,
    int? countDoneTotal,
    int? countUnDoneTotal,
  }) {
    return TaskModel(
      id: id ?? this.id,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      title: title ?? this.title,
      countOnTask: countOnTask ?? this.countOnTask,
      countOnTaskDone: countOnTaskDone ?? this.countOnTaskDone,
      countDoneTotal: countDoneTotal ?? this.countDoneTotal,
      countUnDoneTotal: countUnDoneTotal ?? this.countUnDoneTotal,
    );
  }
}
