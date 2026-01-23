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
import '../../domain/models/course.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CoupleService _coupleService = CoupleService();
  final CourseService _courseService = CourseService();
  List<Course>? _courseList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String? coupleId = await _coupleService.findMyCoupleId(FirebaseAuth.instance.currentUser!.uid); //TODO. 임시. 나중에 로그인 할 때 객체 상태로 coupleId 가지고 있기.
    if(coupleId != null) {
      List<Course>? courseList = await _courseService.readCoursesByCoupleId(coupleId);
      setState(() {
        _courseList = courseList;
        print(_courseList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HomeSummarySection(),
            SizedBox(height: 78),
            NextDateCard(),
            HomeRecentCourseSection(
              itemCount: _courseList!.length < 5 ? _courseList!.length : 5,
              onTapAll: () { context.go('/course'); },
              itemBuilder: (context, index, cardWidth) {
                final courseList = _courseList ?? [];
                final course = courseList[index];
                return DecoDateCard(data: course);
              },
            ),
            HomeFavoritePlaceSection(),
            HomeTodayRecommendationSection(),
          ],
        ),
      ),
    );
  }
}
