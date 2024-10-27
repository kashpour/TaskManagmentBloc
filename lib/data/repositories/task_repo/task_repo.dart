import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/home/models/task_model.dart';

abstract class TaskRepo {
  void addTask(TaskModel task);
  Stream<QuerySnapshot> loadTask();
  void updateTask(TaskModel task, String documnetId);
  void deleteTask(String documnetId);
}


