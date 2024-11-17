class UserModel {
  final String? email;
  final String? username;

  UserModel({required this.email, required this.username});

  @override
  String toString() {
    return 'email: $email, username: $username';
  }
}
