import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  final String? id;
  final String? name;
  final String? type;
  final String? address;
  final double? lan;
  final double? lon;
  final List<String?>? pictures;
  final String? memo;
  final String? courseId;

  const Place({
    this.id,
    this.name,
    this.type,
    this.address,
    this.lan,
    this.lon,
    this.pictures,
    this.memo,
    this.courseId,
  });

  factory Place.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Place(
      id: doc.id,
      name: data['name'],
      type: data['type'],
      address: data['address'],
      lan: data['lan'],
      lon: data['lon'],
      pictures: data['pictures'],
      memo: data['memo'],
      courseId: data['courseId'],
    );
  }

  Place copyWith({
    String? id,
    String? name,
    String? type,
    String? address,
    double? lan,
    double? lon,
    List<String>? pictures,
    String? memo,
    String? courseId,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      lan: lan ?? this.lan,
      lon: lon ?? this.lon,
      pictures: pictures ?? this.pictures,
      memo: memo ?? this.memo,
      courseId: courseId ?? this.courseId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'address': address,
      'lan': lan,
      'lon': lon,
      'pictures': pictures,
      'memo': memo,
      'courseId': courseId,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    final rawPictures = map['pictures'];

    final pictures = (rawPictures is List)
        ? rawPictures
        .whereType<String>()
        .toList()
        : <String>[];

    return Place(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      address: map['address'],
      lan: map['lan'],
      lon: map['lon'],
      pictures: pictures,
      memo: map['memo'],
      courseId: map['courseId'],
    );
  }
}
