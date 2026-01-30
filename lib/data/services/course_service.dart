import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:deco/domain/models/place.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/models/couple.dart';
import '../../domain/models/course.dart';
import '../../domain/models/next_date_info.dart';
import 'couple_service.dart';

class CourseService {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  final CoupleService _coupleService = CoupleService();

  Future<void> createCourse(Course course) async {
    Couple? couple1 = await _coupleService.readMyCoupleByInvitor();
    Couple? couple2 = await _coupleService.readMyCoupleByInvitee();
    String? coupleId;
    if (couple1 != null && couple1.invitor == course.writer) {
      coupleId = couple1.id;
    }
    if (couple2 != null && couple2.invitee == course.writer) {
      coupleId = couple2.id;
    }

    //1. course 만든다.
    final courseCollection = _fs.collection('course');
    final docCourseRef = await courseCollection.add(course.toMap());
    String courseId = docCourseRef.id;
    docCourseRef.update({'id': courseId});
    docCourseRef.update({'coupleId': coupleId});

    //2. course 대표 이미지를 저장한다.
    if (course.picture != null) {
      String downloadUrl = await uploadImage(
        path: course.picture!,
        courseId: courseId,
      );
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

        if (place.pictures != null && place.pictures!.isNotEmpty) {
          List<String?> pictures = place.pictures!;
          List<String?> downloadUrls = [];
          for (var path in pictures) {
            //4. place 이미지를 저장한다.
            if (path != null) {
              String downloadUrl = await uploadImage(
                path: path,
                courseId: courseId,
                placeId: placeId,
              );
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

      //TODO. placeId == null일 경우, 대표 이미지라고 생각???
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

  Future<List<Course>?> readCoursesByCoupleId(String coupleId) async {
    final courseCollection = _fs.collection('course');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot1 =
        await courseCollection.where('coupleId', isEqualTo: coupleId).get();

    if (querySnapshot1.docs.isEmpty) return null;

    final queryDocumentSnapshot1 = querySnapshot1.docs;
    List<Course> returnCourseData = [];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in queryDocumentSnapshot1) {
      Course course = Course.fromMap(doc.data());
      String courseId = course.id!;

      final placeCollection = _fs.collection('place');
      final QuerySnapshot<Map<String, dynamic>> querySnapshot2 =
          await placeCollection.where('courseId', isEqualTo: courseId).get();

      if (querySnapshot2.docs.isEmpty) {
        returnCourseData.add(course);
        break;
      }

      final queryDocumentSnapshot2 = querySnapshot2.docs;

      List<Place> placeData = [];
      for (final QueryDocumentSnapshot<Map<String, dynamic>> doc2
          in queryDocumentSnapshot2) {
        placeData.add(Place.fromMap(doc2.data()));
      }

      course.places = placeData;
      returnCourseData.add(course);
    }

    return returnCourseData;
  }

  Future<List<Course>?> readPublicCourses() async {
    final courseCollection = _fs.collection('course');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot1 =
        await courseCollection.where('isPublic', isEqualTo: true).get();

    if (querySnapshot1.docs.isEmpty) return null;

    final queryDocumentSnapshot1 = querySnapshot1.docs;
    List<Course> returnCourseData = [];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in queryDocumentSnapshot1) {
      Course course = Course.fromMap(doc.data());
      String courseId = course.id!;

      final placeCollection = _fs.collection('place');
      final QuerySnapshot<Map<String, dynamic>> querySnapshot2 =
          await placeCollection.where('courseId', isEqualTo: courseId).get();

      if (querySnapshot2.docs.isEmpty) {
        returnCourseData.add(course);
        break;
      }

      final queryDocumentSnapshot2 = querySnapshot2.docs;

      List<Place> placeData = [];
      for (final QueryDocumentSnapshot<Map<String, dynamic>> doc2
          in queryDocumentSnapshot2) {
        placeData.add(Place.fromMap(doc2.data()));
      }

      course.places = placeData;
      returnCourseData.add(course);
    }

    return returnCourseData;
  }

  Future<NextDateInfo?> fetchNextDateInfo({required String coupleId}) async {
    final courseCollection = _fs.collection('course');
    final querySnapshot = await courseCollection
        .where('coupleId', isEqualTo: coupleId)
        .where('date', isGreaterThanOrEqualTo: DateTime.now().toIso8601String())
        .orderBy('date')
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    final data = querySnapshot.docs.first.data();
    final dateAt = DateTime.parse(data['date'] as String);

    return _formatNextDate(dateAt);
  }

  NextDateInfo _formatNextDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    final diffDays = target.difference(today).inDays;

    final dayText = diffDays == 0
        ? '오늘'
        : diffDays == 1
        ? '내일'
        : _weekdayKo(date.weekday);

    final dateStr = DateFormat('M/d(E)', 'ko_KR').format(date);

    final dday = diffDays == 0 ? '오늘' : 'D-$diffDays';
    final message = '$dday · $dateStr';

    return NextDateInfo(dayText: dayText, message: message);
  }

  String _weekdayKo(int weekday) {
    switch (weekday) {
      case DateTime.monday: return '월요일';
      case DateTime.tuesday: return '화요일';
      case DateTime.wednesday: return '수요일';
      case DateTime.thursday: return '목요일';
      case DateTime.friday: return '금요일';
      case DateTime.saturday: return '토요일';
      case DateTime.sunday: return '일요일';
      default: return '';
    }
  }
}
