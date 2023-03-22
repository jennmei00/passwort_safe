class UserModel {
  final String name;
  final String? password;
  final String email;

  UserModel({required this.name, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
      return UserModel(
        name: map['name'] as String,
        email: map['email'] as String,
        password: map['password'] as String,
      );
  }
}
