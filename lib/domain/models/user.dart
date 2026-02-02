import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deco/ui/mypage/profile_edit_screen.dart';

class User {
  final String? userId;
  final String? email;
  final String? password;
  final String? nickname;
  final DateTime? birth;
  final String? gender;
  final String? introduce;
  final BearColor? bearColor;

  const User({
    this.userId,
    this.email,
    this.password,
    this.nickname,
    this.birth,
    this.gender,
    this.introduce,
    this.bearColor,
});

  factory User.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return User(
      userId: doc.id,
      email: data['email'],
      nickname: data['nickname'],
      password: data['password'],
      birth: (data['birth'] as Timestamp?)?.toDate(),
      gender: data['gender'],
      introduce: data['introduce'],
      bearColor: BearColor.values.firstWhere((e) => e.name == data['bearColor'], orElse: () => BearColor.pink,),
    );
  }

  User copyWith({
    String? email,
    String? password,
    String? nickname,
    DateTime? birth,
    String? gender,
    String? introduce,
    BearColor? bearColor,
}) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      birth: birth ?? this.birth,
      gender: gender ?? this.gender,
      introduce: introduce ?? this.introduce,
      bearColor: bearColor ?? this.bearColor,
    );
  }
}