import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/course.dart';
import '../core/themes/deco_theme_extension.dart';
import '../core/widgets/deco_gradient_app_bar.dart';
import 'widgets/sections/calendar_day_courses_section.dart';
import 'widgets/sections/calendar_month_section.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Event>> _events = {};

  void _onSelectDay(DateTime day) {
    setState(() {
      _selectedDay = DateTime(day.year, day.month, day.day);
    });
  }

  void _updateEvents(List<Course> courses) {
    setState(() {
      _events = buildEventMap(courses);
    });
  }

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
                children: [
                  CalendarMonthSection(
                    selectedDay: _selectedDay,
                    onSelectDay: _onSelectDay,
                    onCoursesLoaded: _updateEvents,
                  ),
                  CalendarDayCoursesSection(
                    selectedDay: _selectedDay,
                    events: _events,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { context.push('/create-course');},
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: theme.primaryGradient,
          ),
          child: Icon(Icons.add, size: 40),
        ),
      ),
    );
  }
}
