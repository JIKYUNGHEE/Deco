import 'package:deco/data/services/couple_service.dart';
import 'package:deco/data/services/course_service.dart';
import 'package:deco/ui/core/themes/deco_theme_extension.dart';
import 'package:deco/ui/core/widgets/deco_gradient_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/course.dart';
import 'widgets/sections/course_cta_section.dart';
import 'widgets/sections/course_filter_section.dart';
import 'widgets/sections/course_list_section.dart';
import 'widgets/sections/course_tab_section.dart';

class CourseScreen extends StatefulWidget {
  final String? initialTab;

  const CourseScreen({super.key, this.initialTab});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  CourseTab _currentTab = CourseTab.my;

  final CoupleService _coupleService = CoupleService();
  final CourseService _courseService = CourseService();
  List<Course>? _courseList = [];

  CourseSortFilter _sort = CourseSortFilter.latest;
  CoursePeriodFilter _period = CoursePeriodFilter.all;
  CourseRegionFilter _region = CourseRegionFilter.all;

  @override
  void initState() {
    super.initState();
    if (widget.initialTab == 'public') {
      _currentTab = CourseTab.public;
      fetchPublicData();
    } else {
      _currentTab = CourseTab.my;
      fetchData();
    }
  }

  Future<void> fetchData() async {
    String? coupleId = await _coupleService.findMyCoupleId(FirebaseAuth.instance.currentUser!.uid); //TODO. 임시. 나중에 로그인 할 때 객체 상태로 coupleId 가지고 있기.
    if (coupleId != null) {
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
              CourseTabSection(
                current: _currentTab,
                onChanged: (tab) {
                  setState(() {
                    _currentTab = tab;
                    if (tab == CourseTab.my) {
                      fetchData();
                      context.go('/course?tab=my');
                    } else {
                      fetchPublicData();
                      context.go('/course?tab=public');
                    }
                  });
                },
              ),
              SizedBox(height: 8),
              CourseFilterSection(
                sort: _sort,
                period: _period,
                region: _region,
                onSortChanged: (v) => setState(() => _sort = v),
                onPeriodChanged: (v) => setState(() => _period = v),
                onRegionChanged: (v) => setState(() => _region = v),
              ),
              SizedBox(height: 8),
              CourseCtaSection(
                onCreated: () async {
                  if (_currentTab == CourseTab.my) {
                    await fetchData();
                  } else {
                    await fetchPublicData();
                  }
                },
              ),
              SizedBox(height: 16),
              CourseListSection(courseList: _courseList),
            ],
          ),
        ),
      ],
    );
  }
}
