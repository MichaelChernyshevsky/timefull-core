abstract class TaskInterface {
  void getTasksApi({required String userId}) {}
  void deleteTasksApi({required String taskId}) {}
  void editTasksApi({
    required String taskId,
    required String title,
    required String description,
    required String date,
    required String countOnDay,
    required String countOnTask,
  }) {}
  void addTasksApi({
    required String userId,
    required String title,
    required String description,
    required String date,
    required String countOnDay,
    required String countOnTask,
  }) {}
  void statEditTasksApi({required String userId, required String countDone, required String countUnDone}) {}
}
