import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deco/ui/mypage/profile_edit_screen.dart';

import '../../domain/models/user.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  Future<User?> getUserById(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return User.fromJson(doc);
  }

  Future<void> updateBearColor(String uid, BearColor bearColor) {
    return _db.collection('users').doc(uid).update({
      'bearColor': bearColor.name,
    });
  }

  Future<void> updateNickname(String uid, String nickname) {
    return _db.collection('users').doc(uid).update({
      'nickname': nickname,
    });
  }

  Future<void> updateBirth(String uid, DateTime birth) {
    return _db.collection('users').doc(uid).update({
      'birth': birth,
    });
  }

  Future<void> updateGender(String uid, Gender gender) {
    return _db.collection('users').doc(uid).update({
      'gender': gender.name,
    });
  }

  Future<void> updateIntroduce(String uid, String introduce) {
    return _db.collection('users').doc(uid).update({
      'introduce': introduce,
    });
  }

  Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).delete();
  }
}