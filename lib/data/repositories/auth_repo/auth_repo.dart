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

