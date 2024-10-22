import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<UserCredential> lgoinWithEmailAndPassword(
      String email, String password);
  Future<UserCredential> signupWithEmailAndPassword(
      String email, String password);
  Future forgetUserPassword(String email);
  User? getCurrentUser();
}

class DevAuthRepo implements AuthRepo {
  final _auth = FirebaseAuth.instance;

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  @override
  Future<UserCredential> signupWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  @override
  Future<UserCredential> lgoinWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  @override
  Future forgetUserPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }
}
