import 'package:deco/data/services/couple_service.dart';
import 'package:deco/data/services/course_service.dart';
import 'package:deco/ui/core/themes/deco_theme_extension.dart';
import 'package:deco/ui/core/widgets/deco_gradient_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/course.dart';
import 'widgets/sections/course_cta_section.dart';
import 'widgets/sections/course_filter_section.dart';
import 'widgets/sections/course_list_section.dart';
import 'widgets/sections/course_tab_section.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final CoupleService _coupleService = CoupleService();
  final CourseService _courseService = CourseService();
  List<Course>? _courseList = [];

  CourseSortFilter _sort = CourseSortFilter.latest;
  CoursePeriodFilter _period = CoursePeriodFilter.all;
  CourseRegionFilter _region = CourseRegionFilter.all;

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
     });
    }
  }

  Future<void> fetchPublicData() async {
    List<Course>? courseList = await _courseService.readPublicCourses();
    setState(() {
      _courseList = courseList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DecoThemeExtension>()!;
    return Column(
      children: [
        DecoGradientAppBar(title: '코스', gradient: theme.primaryGradient),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              CourseTabSection(current: CourseTab.my, onChanged: (tab) {
                if(tab.name == CourseTab.my.name) {
                  fetchData();
                } else {
                  fetchPublicData();
                }
              }),
              SizedBox(height: 8,),
              CourseFilterSection(
                sort: _sort,
                period: _period,
                region: _region,
                onSortChanged: (v) => setState(() => _sort = v),
                onPeriodChanged: (v) => setState(() => _period = v),
                onRegionChanged: (v) => setState(() => _region = v),
              ),
              SizedBox(height: 8,),
              CourseCtaSection(),
              SizedBox(height: 16,),
              CourseListSection(courseList: _courseList),
            ],
          ),
        ),
      ],
    );
  }


}
