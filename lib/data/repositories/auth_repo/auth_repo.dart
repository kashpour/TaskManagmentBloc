import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/models/user_model.dart';

abstract class AuthRepo {
  Future<UserCredential> lgoinWithEmailAndPassword(
      String email, String password);
  Future<UserCredential> signupWithEmailAndPassword(
      String email, String password);
  Future forgetUserPassword(String email);
  UserModel getUserInfo();
  void signOutUser();
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
  Future<UserCredential> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseAuthErrorMessage(e));
    }
  }

  @override
  Future<UserCredential> lgoinWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return authResult;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseAuthErrorMessage(e));
    }
  }

  @override
  Future forgetUserPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseAuthErrorMessage(e));
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
  void signOutUser() async {
    await _auth.signOut();
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
  Future<UserCredential> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseAuthErrorMessage(e));
    }
  }

  @override
  Future<UserCredential> lgoinWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: 'admin@gmail.com',
          password: '123456'); // testing for development
      return authResult;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseAuthErrorMessage(e));
    }
  }

  @override
  Future forgetUserPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseAuthErrorMessage(e));
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
  void signOutUser() async {
    await _auth.signOut();
  }
}
