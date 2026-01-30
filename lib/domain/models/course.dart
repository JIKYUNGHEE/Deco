import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deco/domain/models/place.dart';

class Course {
  final String? id;
  final String? title;
  final DateTime? date;
  List<Place>? places;
  final String? daySentence;
  final String? memo;
  final String? picture;
  final String? writer;
  final String? coupleId;
  final bool? isPublic;
  final List<String>? favorites;

  Course({
    this.id,
    this.title,
    this.date,
    this.places,
    this.daySentence,
    this.memo,
    this.picture,
    this.writer,
    this.coupleId,
    this.isPublic,
    this.favorites,
  });

  factory Course.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Course(
      id: doc.id,
      title: data['title'],
      date: data['date'],
      places: data['places'],
      daySentence: data['daySentence'],
      memo: data['memo'],
      picture: data['picture'],
      writer: data['writer'],
      coupleId: data['coupleId'],
      isPublic: data['isPublic'],
      favorites: data['favorites'],
    );
  }

  Course copyWith({
    String? id,
    String? title,
    DateTime? date,
    List<Place>? places,
    String? daySentence,
    String? memo,
    String? picture,
    String? writer,
    String? coupleId,
    bool? isPublic,
    List<String>? favorites,
}) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      date:  date ?? this.date,
      places: places ?? this.places,
      daySentence: daySentence ?? this.daySentence,
      memo: memo ?? this.memo,
      picture: picture ?? this.picture,
      writer: writer ?? this.writer,
      coupleId: coupleId ?? this.coupleId,
      isPublic: isPublic ?? this.isPublic,
      favorites: favorites ?? this.favorites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date':  date?.toIso8601String(),
      'daySentence': daySentence,
      'memo': memo,
      'picture': picture,
      'writer': writer,
      'coupleId': coupleId,
      'isPublic': isPublic,
      'favorites': favorites,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      places: map['places'],
      daySentence: map['daySentence'],
      memo: map['memo'],
      picture: map['picture'],
      writer: map['writer'],
      coupleId: map['coupleId'],
      isPublic: map['isPublic'],
      favorites: map['favorites'],
    );
  }
}
