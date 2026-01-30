import 'package:deco/data/services/user_service.dart';
import 'package:deco/ui/home/widgets/components/deco_date_card.dart';
import 'package:deco/ui/home/widgets/components/next_date_card.dart';
import 'package:deco/ui/home/widgets/sections/home_favorite_place_section.dart';
import 'package:deco/ui/home/widgets/sections/home_recent_course_section.dart';
import 'package:deco/ui/home/widgets/sections/home_summary_section.dart';
import 'package:deco/ui/home/widgets/sections/home_today_recommedation_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/services/couple_service.dart';
import '../../data/services/course_service.dart';
import '../../domain/models/couple.dart';
import '../../domain/models/course.dart';
import '../../domain/models/next_date_info.dart';
import '../../domain/models/user.dart' as model;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CoupleService _coupleService = CoupleService();
  final CourseService _courseService = CourseService();
  final UserService _userService = UserService();
  List<Course>? _courseList = [];
  Couple? couple;
  String _invitorNickName = '';
  String _inviteeNickName = '';
  int _daysTogether = 0;
  int _monthDates = 0;
  NextDateInfo? _nextDate;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String? coupleId = await _coupleService.findMyCoupleId(FirebaseAuth.instance.currentUser!.uid); //TODO. 임시. 나중에 로그인 할 때 객체 상태로 coupleId 가지고 있기.
    if (coupleId != null) {
      couple = await _coupleService.readCouple(coupleId);
      List<Course>? courseList = await _courseService.readCoursesByCoupleId(coupleId);
      NextDateInfo? nextDateInfo = await _courseService.fetchNextDateInfo(coupleId: coupleId);

      String invitorNickName = '';
      String inviteeNickName = '';
      int daysTogether = 0;
      int monthDate = 0;
      if (couple != null) {
        if (couple?.invitor != null) {
          model.User? invitor = await _userService.getUserById(couple!.invitor!);
          invitorNickName = invitor?.nickname ?? '🙂';
        }
        if (couple?.invitee != null) {
          model.User? invitee = await _userService.getUserById(couple!.invitee!);
          inviteeNickName = invitee?.nickname ?? '🙂';
        }
        if (couple?.anniversaryDate != null) {
          daysTogether = _calcDday(couple!.anniversaryDate!);
        }
        monthDate = _countThisMonthCourses(courseList);
      }

      setState(() {
        _courseList = courseList;
        _invitorNickName = invitorNickName;
        _inviteeNickName = inviteeNickName;
        _daysTogether = daysTogether;
        _monthDates = monthDate;
        _nextDate = nextDateInfo;
      });
    }
  }

  int _calcDday(DateTime? anniversary) {
    if (anniversary == null) return 0;
    final start = DateTime(
      anniversary.year,
      anniversary.month,
      anniversary.day,
    );
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return today.difference(start).inDays;
  }

  int _countThisMonthCourses(List<Course>? courses) {
    if (courses == null) return 0;

    final now = DateTime.now();
    return courses.where((c) {
      final d = c.date;
      if (d == null) return false;
      return d.year == now.year && d.month == now.month;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HomeSummarySection(
              invitor: _invitorNickName,
              invitee: _inviteeNickName,
              daysTogether: _daysTogether,
              totalCourses: _courseList?.length ?? 0,
              monthDates: _monthDates,
            ),
            SizedBox(height: 78),
            if(_nextDate == null)
              NextDateCard(dayText: '아직 없음', message: '다음 데이트 코스를 등록해볼까요? 💘',),
            if(_nextDate != null)
              NextDateCard(dayText: _nextDate!.dayText, message: _nextDate!.message,),
            HomeRecentCourseSection(
              itemCount: _courseList!.length < 5 ? _courseList!.length : 5,
              onTapAll: () {
                context.go('/course');
              },
              itemBuilder: (context, index, cardWidth) {
                final courseList = _courseList ?? [];
                final course = courseList[index];
                return DecoDateCard(data: course);
              },
            ),
            // HomeFavoritePlaceSection(),
            // HomeTodayRecommendationSection(),
          ],
        ),
      ),
    );
  }
}
