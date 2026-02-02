import 'package:deco/viewmodels/couple_summary_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/mypage_settings_section.dart';
import 'widgets/mypage_summary_section.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    final summary = context.watch<CoupleSummaryState>();

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Column(
            children: [
              MyPageSummarySection(
                myNickName: summary.myNickName,
                coupleNickName: summary.coupleNickName,
                anniversaryDate: summary.anniversaryDate,
                daysTogether: summary.daysTogether,
                totalCourses: summary.totalCourses,
                monthDates: summary.monthDates,
              ),
              SizedBox(height: 16),
              MyPageSettingsSection(),
              SizedBox(height: 24)
            ],
          ),
      ),
    );
  }
}
