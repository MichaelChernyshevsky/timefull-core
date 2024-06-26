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

class TaskModel {
  final int countOnDay;
  final int countOnTask;
  final String date;
  final String description;
  final String id;
  final String title;
  final String userId;

  TaskModel({
    required this.countOnDay,
    required this.countOnTask,
    required this.date,
    required this.description,
    required this.id,
    required this.title,
    required this.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        countOnDay: json["countOnDay"] as int,
        countOnTask: json["countOnTask"] as int,
        date: json["date"] as String,
        description: json["description"] as String,
        id: json["id"].toString(),
        title: json["title"] as String,
        userId: json["userId"] as String,
      );
}
