import 'package:deco/data/services/couple_service.dart';
import 'package:deco/data/services/course_service.dart';
import 'package:deco/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../domain/models/course.dart';
import '../domain/models/user.dart' as model;

class CoupleSummaryState extends ChangeNotifier {
  final CoupleService _coupleService;
  final CourseService _courseService;
  final UserService _userService;

  CoupleSummaryState({
    CoupleService? coupleService,
    CourseService? courseService,
    UserService? userService,
  }) : _coupleService = coupleService ?? CoupleService(),
       _courseService = courseService ?? CourseService(),
       _userService = userService ?? UserService();

  bool _loading = false;

  bool get loading => _loading;

  String? _coupleId;

  String? get coupleId => _coupleId;

  String myNickName = '';
  String coupleNickName = '';
  int daysTogether = 0;
  int totalCourses = 0;
  int monthDates = 0;

  String? errorMessage;

  Future<void> load() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      errorMessage = '로그인이 필요합니다.';
      notifyListeners();
      return;
    }

    _loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final id = await _coupleService.findMyCoupleId(uid);
      _coupleId = id;

      if (id == null) {
        myNickName = '';
        coupleNickName = '';
        daysTogether = 0;
        totalCourses = 0;
        monthDates = 0;
        return;
      }
      final couple = await _coupleService.readCouple(id);
      if (couple?.anniversaryDate != null) {
        final a = couple!.anniversaryDate!;
        final today = DateTime.now();
        final start = DateTime(a.year, a.month, a.day);
        final now = DateTime(today.year, today.month, today.day);
        daysTogether = now.difference(start).inDays + 1; // D+1 기준
      } else {
        daysTogether = 0;
      }

      List<Course>? courseList = await _courseService.readCoursesByCoupleId(id);
      totalCourses = courseList?.length ?? 0;
      monthDates = countThisMonthCourses(courseList);

      if (couple?.invitor != null) {
        model.User? invitor = await _userService.getUserById(couple!.invitor!);
        if(invitor?.userId == uid) {
          myNickName = invitor?.nickname ?? '🙂';
        } else {
          coupleNickName = invitor?.nickname ?? '🙂';
        }
      }

      if (couple?.invitee != null) {
        model.User? invitee = await _userService.getUserById(couple!.invitee!);
        if(invitee?.userId == uid) {
          myNickName = invitee?.nickname ?? '🙂';
        } else {
          coupleNickName = invitee?.nickname ?? '🙂';
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  int countThisMonthCourses(List<Course>? courses) {
    if (courses == null) return 0;

    final now = DateTime.now();
    return courses.where((c) {
      final d = c.date;
      if (d == null) return false;
      return d.year == now.year && d.month == now.month;
    }).length;
  }
}
