
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../features/home/models/task_model.dart';
import '../../../injectable/injectable.dart';
import '../auth_repo/auth_repo.dart';
import '../auth_repo/dev_auth_repo.dart';
import 'task_repo.dart';

@Injectable(as: TaskRepo, env: [Env.prod])
class ProdTaskRepo implements TaskRepo {
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