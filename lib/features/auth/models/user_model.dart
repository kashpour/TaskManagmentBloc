class UserModel {
  final String? email;
  final String? username;

  UserModel({required this.email, required this.username});

  @override
  String toString() => 'email: $email, username: $username';
}
