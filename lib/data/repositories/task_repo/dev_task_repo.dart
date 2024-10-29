import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/home/models/task_model.dart';
import 'task_repo.dart';

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
