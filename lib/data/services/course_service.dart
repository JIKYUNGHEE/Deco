import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/models/couple.dart';
import '../../domain/models/course.dart';
import 'couple_service.dart';

class CourseService {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  final CoupleService _coupleService = CoupleService();

  Future<void> createCourse(Course course) async {
    Couple? couple1 = await _coupleService.readMyCoupleByInvitor();
    Couple? couple2 = await _coupleService.readMyCoupleByInvitee();
    String? coupleId;
    if(couple1 != null && couple1.invitor == course.writer) {
      coupleId = couple1.id;
    }
    if(couple2 != null && couple2.invitee == course.writer) {
      coupleId = couple2.id;
    }

    //1. course 만든다.
    final courseCollection = _fs.collection('course');
    final docCourseRef = await courseCollection.add(course.toMap());
    String courseId = docCourseRef.id;
    docCourseRef.update({'id': courseId});
    docCourseRef.update({'coupleId': coupleId});

    //2. course 대표 이미지를 저장한다.
    // uploadCourseImage(bytes: bytes, path: path, courseId: courseId);

    if (course.places != null) {
      final places = course.places ?? [];
      final placeCollection = _fs.collection('place');

      for (var place in places) {
        //3. place 만든다.
        final docPlaceRef = await placeCollection.add(place.toMap());
        docPlaceRef.update({'id': docPlaceRef.id});
        docPlaceRef.update({'courseId': courseId});

        //4. place 이미지를 저장한다.
        // uploadCourseImage(bytes: bytes, path: path, courseId: courseId);
      }
    }
  }

  Future<String> uploadImage({
    required Uint8List bytes,
    required String path,
    String? courseId,
    String? placeId,
  }) async {
    if (courseId == null) throw Exception('잘못된 접근입니다.');
    try {
      final courseRef = storageRef.child(
        'course_image/${courseId}_${placeId}_image.png',
      );
      final metadata = SettableMetadata(
        contentType: 'image/png',
        customMetadata: {'picked-file-path': path},
      );
      await courseRef.putData(bytes, metadata);
      final downloadUrl = await courseRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('upload 실패: $e');
    }
  }
}
