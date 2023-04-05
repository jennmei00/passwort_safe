class UserModel {
  final String name;
  final String? password;
  final String email;
  final int securityQuestionIndex;
  final String? securityAnswer;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.securityQuestionIndex,
    required this.securityAnswer,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    int? securityQuestionIndex,
    String? securityAnswer,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      securityQuestionIndex:
          securityQuestionIndex ?? this.securityQuestionIndex,
      securityAnswer: securityAnswer ?? this.securityAnswer,
    );
  }

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
      securityQuestionIndex: 1,
      securityAnswer: '',
    );
  }
}
