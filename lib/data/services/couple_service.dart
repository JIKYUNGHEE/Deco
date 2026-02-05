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

  Future<String?> findMyCoupleId(String uid) async {
    Couple? couple1 = await readMyCoupleByInvitor();
    Couple? couple2 = await readMyCoupleByInvitee();
    String? coupleId;
    if (couple1 != null && couple1.invitor == uid && couple1.invitee != null) {
      coupleId = couple1.id;
    }
    if (couple2 != null && couple2.invitee == uid && couple2.invitor != null) {
      coupleId = couple2.id;
    }

    return coupleId;
  }

  Future<Couple?> readCouple(String coupleId) async {
    final couplesCollection = _fs.collection('couples');
    final documentSnapshot = await couplesCollection.doc(coupleId).get();
    if (!documentSnapshot.exists) throw Exception('no data');
    final mapData = documentSnapshot.data()!;

    return Couple.fromMap(mapData);
  }


  Future<Couple?> readMyCoupleByCode(String code) async {
    final couplesCollection = _fs.collection('couples');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await couplesCollection
            .where('code', isEqualTo: code)
            .where('deleteYN', isEqualTo: false)
            .where('codeExpireDate', isGreaterThanOrEqualTo: DateTime.now())
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

  Future<void> updateCoupleAnniversaryDate(String coupleId, DateTime anniversaryDate) async {
    final couplesCollection = _fs.collection('couples');
    try {
      await  couplesCollection.doc(coupleId).update({
        'anniversaryDate': anniversaryDate,
      });
    } catch(e) {
      throw Exception('update 실패: $e');
    }
  }

  Future<void> deleteCoupleAccount(String coupleId) async {
    final couplesCollection = _fs.collection('couples');
    try {
      await  couplesCollection.doc(coupleId).update({
        'deleteYN': true,
      });
    } catch(e) {
      throw Exception('update 실패: $e');
    }
  }

  Future<void> detachUserFromCouples(String uid) async {
    final couplesCollection = _fs.collection('couples');
    final q1 = await couplesCollection.where('invitor', isEqualTo: uid).where('deleteYN', isEqualTo: false).limit(1).get();
    if(q1.docs.isNotEmpty) {
      await q1.docs.first.reference.update({'invitor': null});
      return;
    }

    final q2 = await couplesCollection.where('invitee', isEqualTo: uid).where('deleteYN', isEqualTo: false).limit(1).get();
    if(q2.docs.isNotEmpty) {
      await q2.docs.first.reference.update({'invitee': null});
      return;
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
