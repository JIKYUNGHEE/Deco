import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? userId;
  final String? email;
  final String? password;
  final String? nickname;

  const User({
    this.userId,
    this.email,
    this.password,
    this.nickname,
});

  factory User.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return User(
      userId: doc.id,
      email: data['email'],
      nickname: data['nickname'],
      password: data['password'],
    );
  }

  User copyWith({
    String? email,
    String? password,
    String? nickname,
}) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
    );
  }
}