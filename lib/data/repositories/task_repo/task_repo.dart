import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/home/models/task_model.dart';
import '../auth_repo/auth_repo.dart';

abstract class TaskRepo {
  void addTask(TaskModel task);
  Stream<QuerySnapshot> loadTask();
  void updateTask(TaskModel task, String documnetId);
  void deleteTask(String documnetId);
}

class ProdTaskRepo implements TaskRepo {
  final AuthRepo prodAuthRepo;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProdTaskRepo({required this.prodAuthRepo});

  @override
  void addTask(TaskModel task) async {
    final String taskColectionName = prodAuthRepo.getUserInfo().email!;
    _firestore.collection(taskColectionName).add(task.toJson());
  }

  @override
  Stream<QuerySnapshot> loadTask() {
    final String taskColectionName = prodAuthRepo.getUserInfo().email!;

    return _firestore.collection(taskColectionName).snapshots();
  }

  @override
  void updateTask(TaskModel task, String documnetId) {
    final String taskColectionName = prodAuthRepo.getUserInfo().email!;

    _firestore
        .collection(taskColectionName)
        .doc(documnetId)
        .update(task.toJson());
  }

  @override
  void deleteTask(String documnetId) {
    final String taskColectionName = prodAuthRepo.getUserInfo().email!;

    _firestore.collection(taskColectionName).doc(documnetId).delete();
  }
}

class DevTaskRepo implements TaskRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String taskColectionName =
      'development'; // testing for development

  @override
  void addTask(TaskModel task) async {
    _firestore.collection(taskColectionName).add(task.toJson());
  }

  @override
  Stream<QuerySnapshot> loadTask() {
    return _firestore.collection(taskColectionName).snapshots();
  }

  @override
  void updateTask(TaskModel task, String documnetId) {
    _firestore
        .collection(taskColectionName)
        .doc(documnetId)
        .update(task.toJson());
  }

  @override
  void deleteTask(String documnetId) {
    _firestore.collection(taskColectionName).doc(documnetId).delete();
  }
}
