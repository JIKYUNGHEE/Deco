import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/couple.dart';

class CoupleService {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  Future<void> createCouple() async {
    final code = generateCoupleCode();
    Couple couple = Couple(
      invitor: FirebaseAuth.instance.currentUser?.uid,
      code: code,
      codeExpireDate: DateTime.now().add(Duration(days: 1)),
      deleteYN: false,
    );
    final couplesCollection = _fs.collection('couples');
    final docRef = await couplesCollection.add(couple.toMap());
    docRef.update({'id': docRef.id});
  }

  Future<Couple?> readMyCoupleByInvitor() async {
    final couplesCollection = _fs.collection('couples');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await couplesCollection
            .where('invitor', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .where('deleteYN', isEqualTo: false)
            .limit(1)
            .get();

    if (querySnapshot.docs.isEmpty) return null;

    final doc = querySnapshot.docs.first;

    return Couple.fromMap(doc.data());
  }

  Future<Couple?> readMyCoupleByInvitee() async {
    final couplesCollection = _fs.collection('couples');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await couplesCollection
        .where('invitee', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('deleteYN', isEqualTo: false)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    final doc = querySnapshot.docs.first;

    return Couple.fromMap(doc.data());
  }


  Future<Couple?> readMyCoupleByCode(String code) async {
    final couplesCollection = _fs.collection('couples');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await couplesCollection
            .where('code', isEqualTo: code)
            .where('deleteYN', isEqualTo: false)
            .where('codeExpireDate', isGreaterThanOrEqualTo: DateTime.now().toIso8601String())
            .limit(1)
            .get();

    if (querySnapshot.docs.isEmpty) return null;

    final doc = querySnapshot.docs.first;
    doc.reference.update({'invitee': FirebaseAuth.instance.currentUser?.uid});

    return Couple.fromMap(doc.data());
  }

  Future<void> updateMyCouple(Couple couple) async {
    final couplesCollection = _fs.collection('couples');
    try {
      await couplesCollection.doc(couple.id).update(couple.toMap());
    } catch(e) {
      throw Exception('update 실패: $e');
    }
  }

  String generateCoupleCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    final random = Random.secure();

    final letterPart = List.generate(4, (_) {
      return letters[random.nextInt(letters.length)];
    }).join();

    final numberPart = numbers[random.nextInt(numbers.length)];

    return '$letterPart$numberPart';
  }
}
