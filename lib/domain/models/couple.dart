import 'package:cloud_firestore/cloud_firestore.dart';

class Couple {
  final String? id;
  final String? invitor;
  final String? invitee;
  final DateTime? anniversaryDate;
  final String? code;
  final DateTime? codeExpireDate;
  final bool? deleteYN;

  const Couple({
    this.id,
    this.invitor,
    this.invitee,
    this.anniversaryDate,
    this.code,
    this.codeExpireDate,
    this.deleteYN,
  });

  factory Couple.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Couple(
      id: doc.id,
      invitor: data['invitor'],
      invitee: data['invitee'],
      anniversaryDate: (data['anniversaryDate'] as Timestamp?)?.toDate(),
      code: data['code'],
      codeExpireDate: (data['codeExpireDate'] as Timestamp?)?.toDate(),
      deleteYN: data['deleteYN'],
    );
  }

  Couple copyWith({
    String? id,
    String? invitor,
    String? invitee,
    DateTime? anniversaryDate,
    String? code,
    DateTime? codeExpireDate,
    bool? deleteYN,
}) {
    return Couple(
      id: id ?? this.id,
      invitor: invitor ?? this.invitor,
      invitee: invitee ?? this.invitee,
      anniversaryDate: anniversaryDate ?? this.anniversaryDate,
      code:  code ?? this.code,
      codeExpireDate: codeExpireDate ?? this.codeExpireDate,
      deleteYN: deleteYN ?? this.deleteYN,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invitor': invitor,
      'invitee': invitee,
      'anniversaryDate': anniversaryDate,
      'code': code,
      'codeExpireDate': codeExpireDate,
      'deleteYN': deleteYN,
    };
  }

  factory Couple.fromMap(Map<String, dynamic> map) {
    return Couple(
      id: map['id'],
      invitor: map['invitor'],
      invitee: map['invitee'],
      anniversaryDate: (map['anniversaryDate'] as Timestamp?)?.toDate(),
      code: map['code'],
      codeExpireDate: (map['codeExpireDate'] as Timestamp?)?.toDate(),
      deleteYN: map['deleteYN'],
    );
  }
}
