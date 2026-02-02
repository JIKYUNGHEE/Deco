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
import 'package:provider/provider.dart';

import '../../data/services/couple_service.dart';
import '../../data/services/course_service.dart';
import '../../domain/models/couple.dart';
import '../../domain/models/course.dart';
import '../../domain/models/next_date_info.dart';
import '../../domain/models/user.dart' as model;
import '../../viewmodels/couple_summary_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CoupleService _coupleService = CoupleService();
  final CourseService _courseService = CourseService();
  List<Course>? _courseList = [];
  NextDateInfo? _nextDate;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String? coupleId = await _coupleService.findMyCoupleId(FirebaseAuth.instance.currentUser!.uid); //TODO. 임시. 나중에 로그인 할 때 객체 상태로 coupleId 가지고 있기.
    if (coupleId != null) {
      List<Course> courseList = await _courseService.readCoursesByCoupleId(coupleId) ?? [];
      NextDateInfo? nextDateInfo = await _courseService.fetchNextDateInfo(coupleId: coupleId);

      setState(() {
        _courseList = courseList;
        _nextDate = nextDateInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = context.watch<CoupleSummaryState>();

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HomeSummarySection(
              invitor: summary.myNickName,
              invitee: summary.coupleNickName,
              daysTogether: summary.daysTogether,
              totalCourses: summary.totalCourses,
              monthDates: summary.monthDates,
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
