import 'package:deco/data/services/couple_service.dart';
import 'package:deco/data/services/course_service.dart';
import 'package:deco/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String anniversaryDate = '';
  int daysTogether = 0;
  int totalCourses = 0;
  int monthDates = 0;

  String? errorMessage;

  int _req = 0;

  Future<void> load() async {
    final myReq = ++_req;

    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      if (myReq != _req) return;
      _reset();
      _loading = false;
      errorMessage = '로그인이 필요합니다.';
      notifyListeners();
      return;
    }

    _loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final id = await _coupleService.findMyCoupleId(uid);
      if (myReq != _req) return;
      _coupleId = id;

      if (id == null) {
        _reset();
        notifyListeners();
        return;
      }

      final couple = await _coupleService.readCouple(id);
      if (myReq != _req) return;
      myNickName = '';
      coupleNickName = '';

      if (couple?.anniversaryDate != null) {
        final a = couple!.anniversaryDate!;
        final today = DateTime.now();
        final start = DateTime(a.year, a.month, a.day);
        anniversaryDate = DateFormat('yyyy.MM.dd').format(start);
        final now = DateTime(today.year, today.month, today.day);
        daysTogether = now.difference(start).inDays + 1; // D+1 기준
      } else {
        anniversaryDate = '';
        daysTogether = 0;
      }

      List<Course>? courseList = await _courseService.readCoursesByCoupleId(id);
      if (myReq != _req) return;

      totalCourses = courseList?.length ?? 0;
      monthDates = countThisMonthCourses(courseList);

      if (couple?.invitor != null) {
        model.User? invitor = await _userService.getUserById(couple!.invitor!);
        if (myReq != _req) return;

        if(invitor?.userId == uid) {
          myNickName = invitor?.nickname ?? '🙂';
        } else {
          coupleNickName = invitor?.nickname ?? '🙂';
        }
      }

      if (couple?.invitee != null) {
        model.User? invitee = await _userService.getUserById(couple!.invitee!);
        if (myReq != _req) return;

        if(invitee?.userId == uid) {
          myNickName = invitee?.nickname ?? '🙂';
        } else {
          coupleNickName = invitee?.nickname ?? '🙂';
        }
      }
    } catch (e) {
      if (myReq != _req) return;
      errorMessage = e.toString();
      print(e.toString());
    } finally {
      if (myReq != _req) return;
      _loading = false;
      notifyListeners();
    }
  }

  void _reset() {
    _coupleId = null;
    myNickName = '';
    coupleNickName = '';
    anniversaryDate = '';
    daysTogether = 0;
    totalCourses = 0;
    monthDates = 0;
    errorMessage = null;
  }

  void clear() {
    _req++;
    _loading = false;
    _reset();
    notifyListeners();
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
