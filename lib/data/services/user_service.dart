import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/user.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  Future<User?> getUserById(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return User.fromJson(doc);
  }

  Future<void> updateNickname(String uid, String nickname) {
    return _db.collection('users').doc(uid).update({
      'nickname': nickname,
    });
  }
}