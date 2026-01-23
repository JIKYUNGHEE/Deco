import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path/path.dart';

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
    if(course.picture != null) {
      String downloadUrl = await uploadImage(path: course.picture!, courseId: courseId);
      docCourseRef.update({'picture': downloadUrl});
    }

    if (course.places != null) {
      final places = course.places ?? [];
      final placeCollection = _fs.collection('place');

      for (var place in places) {
        //3. place 만든다.
        final docPlaceRef = await placeCollection.add(place.toMap());
        String placeId = docPlaceRef.id;
        docPlaceRef.update({'id': placeId});
        docPlaceRef.update({'courseId': courseId});

        if(place.pictures != null && place.pictures!.isNotEmpty) {
          List<String?> pictures = place.pictures!;
          List<String?> downloadUrls = [];
          for (var path in pictures) {
            //4. place 이미지를 저장한다.
            if(path != null) {
             String downloadUrl = await uploadImage(path: path, courseId: courseId, placeId: placeId);
             downloadUrls.add(downloadUrl);
            }
          }
          docPlaceRef.update({'pictures': downloadUrls});
        }
      }
    }
    //TODO. success, error 처리 https://firebase.google.com/docs/firestore/manage-data/add-data?hl=ko
  }

  Future<String> uploadImage({
    required String path,
    String? courseId,
    String? placeId,
  }) async {
    if (courseId == null) throw Exception('잘못된 접근입니다.');
    try {
      File file = File(path);
      String fileName = basename(path);

      final courseRef = storageRef.child(
        'course_image/${courseId}_${placeId}_$fileName',
      );

      final metadata = SettableMetadata(
        contentType: 'image/jpg',
        customMetadata: {'picked-file-path': path},
      );

      await courseRef.putFile(file, metadata);
      final downloadUrl = await courseRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('upload 실패: $e');
    }
  }
}
