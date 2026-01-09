import 'package:flutter/material.dart';

import '../core/themes/deco_theme_extension.dart';
import '../core/widgets/deco_gradient_app_bar.dart';
import 'widgets/sections/calendar_day_courses_section.dart';
import 'widgets/sections/calendar_month_section.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DecoThemeExtension>()!;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoGradientAppBar(title: '캘린더', gradient: theme.primaryGradient),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [CalendarMonthSection(), CalendarDayCoursesSection()],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {},
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle, gradient: theme.primaryGradient),
            child: Icon(Icons.add, size: 40,),
        ),),
    );
  }
}
