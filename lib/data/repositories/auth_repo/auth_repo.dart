import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data_provider/network/network_result_state.dart';

import '../../../features/auth/models/user_model.dart';

abstract class AuthRepo {
  Future<NetworkResultState> loginWithEmailAndPassword(
      {required String email, required String password});
  Future<NetworkResultState> signupWithEmailAndPassword(
      String email, String password);
  Future<NetworkResultState> forgetUserPassword(String email);
  UserModel getUserInfo();
  Future<NetworkResultState> signOutUser();
  Future<NetworkResultState> deleteUser();
}

class ProdAuthRepo implements AuthRepo {
  final _auth = FirebaseAuth.instance;

  @override
  UserModel getUserInfo() {
    return UserModel(
      email: _auth.currentUser?.email,
      username: _auth.currentUser?.email!.split('@')[0],
    );
  }

  @override
  Future<NetworkResultState> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return SuccessState(data: authResult);
    } on FirebaseAuthException catch (e) {
      return FailureState(errorMessage: _getFirebaseAuthErrorMessage(e));
    }
  }

  @override
  Future<NetworkResultState> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return SuccessState(data: authResult);
    } on FirebaseAuthException catch (e) {
      return FailureState(errorMessage: _getFirebaseAuthErrorMessage(e));
    }
  }

  @override
  Future<NetworkResultState> forgetUserPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return SuccessState(data: '');
    } on FirebaseAuthException catch (e) {
      return FailureState(errorMessage: _getFirebaseAuthErrorMessage(e));
    }
  }

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'missing-email':
        return 'Please Provide an email address to reset your password';
      case 'email-already-in-use':
        return 'This email is already in use. Please try another email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email and password signups are not enabled.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }

  @override
  Future<NetworkResultState> signOutUser() async {
    try {
      await _auth.signOut();
      return SuccessState(data: '');
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }

  @override
  Future<NetworkResultState> deleteUser() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final String taskColectionName = getUserInfo().email!;
      firestore.collection(taskColectionName).doc().delete();
      await _auth.currentUser!.delete();
      return SuccessState(data: '');
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }
}

class DevAuthRepo implements AuthRepo {
  final _auth = FirebaseAuth.instance;

  @override
  UserModel getUserInfo() {
    return UserModel(
      email: _auth.currentUser?.email,
      username: _auth.currentUser?.email!.split('@')[0],
    );
  }

  @override
  Future<NetworkResultState> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return SuccessState(data: authResult);
    } on FirebaseAuthException catch (e) {
      return FailureState(errorMessage: _getFirebaseAuthErrorMessage(e));
    }
  }

  @override
  Future<NetworkResultState> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: 'admin@gmail.com',
          password: '123456'); // testing for development
      return SuccessState(data: authResult);
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseAuthErrorMessage(e));
    }
  }

  @override
  Future<NetworkResultState> forgetUserPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return SuccessState(data: '');
    } on FirebaseAuthException catch (e) {
      return FailureState(errorMessage: _getFirebaseAuthErrorMessage(e));
    }
  }

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use. Please try another email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email and password signups are not enabled.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }

  @override
  Future<NetworkResultState> signOutUser() async {
    try {
      await _auth.signOut();
      return SuccessState(data: '');
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }

  @override
  Future<NetworkResultState> deleteUser() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final String taskColectionName = getUserInfo().email!;
      firestore.collection(taskColectionName).doc().delete();
      await _auth.currentUser!.delete();
      return SuccessState(data: '');
    } catch (e) {
      return FailureState(errorMessage: e.toString());
    }
  }
}
