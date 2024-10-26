import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/home/models/task_model.dart';
import 'auth_repo.dart';

abstract class TaskRepo {
  void addTask(TaskModel task);
  Stream<QuerySnapshot> loadTask();
  void updateTask(TaskModel task, String documnetId);
  void deleteTask(String documnetId);
}

class DevTaskRepo implements TaskRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthRepo authRepo = DevAuthRepo();
  

  @override
  void addTask(TaskModel task) async {
    final String taskColectionName = authRepo.getUserInfo().email!;
    _firestore.collection(taskColectionName).add(task.toJson());
  }

  @override
  Stream<QuerySnapshot> loadTask() {
    final String taskColectionName = authRepo.getUserInfo().email!;

    return _firestore.collection(taskColectionName).snapshots();
  }

  @override
  void updateTask(TaskModel task, String documnetId) {
    final String taskColectionName = authRepo.getUserInfo().email!;

    _firestore
        .collection(taskColectionName)
        .doc(documnetId)
        .update(task.toJson());
  }

  @override
  void deleteTask(String documnetId) {
    final String taskColectionName = authRepo.getUserInfo().email!;

    _firestore.collection(taskColectionName).doc(documnetId).delete();
  }
}
