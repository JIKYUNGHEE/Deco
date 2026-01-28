import 'package:flutter/material.dart';

import 'widgets/mypage_settings_section.dart';
import 'widgets/mypage_summary_section.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Column(
            children: [
              MyPageSummarySection(),
              SizedBox(height: 16),
              MyPageSettingsSection(),
              SizedBox(height: 24)
            ],
          ),
      ),
    );
  }
}
