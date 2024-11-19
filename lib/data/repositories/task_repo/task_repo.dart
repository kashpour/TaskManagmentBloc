import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/home/models/task_model.dart';
import '../../data_provider/network/network_result_state.dart';
import '../auth_repo/auth_repo.dart';

abstract class TaskRepo {
  Future<NetworkResultState> addTask(TaskModel task);
  Stream<NetworkResultState> loadTask({required bool eventIsCompleted});
  Future<NetworkResultState> updateTask(TaskModel task, String documnetId);
  Future<NetworkResultState> deleteTask(String documnetId);
}

class ProdTaskRepo implements TaskRepo {
  final AuthRepo prodAuthRepo;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProdTaskRepo({required this.prodAuthRepo});

  @override
  Future<NetworkResultState> addTask(TaskModel task) async {
    try {
      final String taskColectionName = prodAuthRepo.getUserInfo().email!;

      await _firestore.collection(taskColectionName).add(task.toJson());
      return SuccessState(data: {});
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }

  @override
  Stream<NetworkResultState> loadTask({required bool eventIsCompleted}) {
    final String taskColectionName = prodAuthRepo.getUserInfo().email!;
    try {
      return _firestore
          .collection(taskColectionName)
          .snapshots()
          .map((querySnapshot) {
        final tasks = querySnapshot.docs
            .map((doc) => TaskModel.fromJson(doc, doc.id))
            .where((task) => task.isCompleted == eventIsCompleted)
            .toList();
        return SuccessState(data: tasks);
      });
    } catch (e) {
      return Stream.value(FailureState(errorMessage: e.toString()));
    }
  }

  @override
  Future<NetworkResultState> updateTask(
      TaskModel task, String documnetId) async {
    try {
      final String taskColectionName = prodAuthRepo.getUserInfo().email!;

      await _firestore
          .collection(taskColectionName)
          .doc(documnetId)
          .update(task.toJson());
      return SuccessState(data: {});
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }

  @override
  Future<NetworkResultState> deleteTask(String documnetId) async {
    try {
      final String taskColectionName = prodAuthRepo.getUserInfo().email!;

      await _firestore.collection(taskColectionName).doc(documnetId).delete();
      return SuccessState(data: {});
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }
}

class DevTaskRepo implements TaskRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String taskColectionName =
      'development'; // testing for development

  @override
  Future<NetworkResultState> addTask(TaskModel task) async {
    try {
      await _firestore.collection(taskColectionName).add(task.toJson());
      return SuccessState(data: {});
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }

  @override
  Stream<NetworkResultState> loadTask({required bool eventIsCompleted}) {
    try {
      return _firestore
          .collection(taskColectionName)
          .snapshots()
          .map((querSnapshot) {
        final tasks = querSnapshot.docs
            .map((doc) => TaskModel.fromJson(doc, doc.id))
            .where((task) => task.isCompleted == eventIsCompleted)
            .toList();
        return SuccessState(data: tasks);
      });
    } catch (e) {
      return Stream.value(FailureState(errorMessage: e.toString()));
    }
  }

  @override
  Future<NetworkResultState> updateTask(
      TaskModel task, String documnetId) async {
    try {
      await _firestore
          .collection(taskColectionName)
          .doc(documnetId)
          .update(task.toJson());
      return SuccessState(data: {});
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }

  @override
  Future<NetworkResultState> deleteTask(String documnetId) async {
    try {
      await _firestore.collection(taskColectionName).doc(documnetId).delete();
      return SuccessState(data: {});
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }
}
