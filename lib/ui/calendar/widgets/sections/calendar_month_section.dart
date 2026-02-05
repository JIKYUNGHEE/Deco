import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../data/services/couple_service.dart';
import '../../../../data/services/course_service.dart';
import '../../../../domain/models/course.dart';

class CalendarMonthSection extends StatefulWidget {
  final DateTime selectedDay;
  final void Function(DateTime day) onSelectDay;
  final void Function(List<Course>) onCoursesLoaded;

  const CalendarMonthSection({
    super.key,
    required this.selectedDay,
    required this.onSelectDay,
    required this.onCoursesLoaded,
  });

  @override
  State<CalendarMonthSection> createState() => _CalendarMonthSectionState();
}

class Event {
  final String title;
  final Course course;

  Event({required this.title, required this.course});
}

Map<DateTime, List<Event>> buildEventMap(List<Course> courses) {
  final Map<DateTime, List<Event>> events = {};

  for (final course in courses) {
    if (course.date == null) continue;

    final dateKey = DateTime(
      course.date!.year,
      course.date!.month,
      course.date!.day,
    );

    final event = Event(title: course.title ?? '제목 없는 데이트', course: course);

    if (events.containsKey(dateKey)) {
      events[dateKey]!.add(event);
    } else {
      events[dateKey] = [event];
    }
  }

  return events;
}

class _CalendarMonthSectionState extends State<CalendarMonthSection> {
  final CoupleService _coupleService = CoupleService();
  final CourseService _courseService = CourseService();

  final CalendarStyle _decoTableCalendarStyle = CalendarStyle(
    todayDecoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.transparent,
      border: Border(
        top: BorderSide(width: 1, color: AppColors.primary),
        bottom: BorderSide(width: 1, color: AppColors.primary),
        right: BorderSide(width: 1, color: AppColors.primary),
        left: BorderSide(width: 1, color: AppColors.primary),
      ),
    ),
    selectedDecoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: AppColors.brandGradient,
    ),
    markersMaxCount: 1,
    markerSize: 8.0,
    markersAnchor: 0.1,
    markerDecoration: BoxDecoration(
      color: AppColors.primary,
      shape: BoxShape.circle,
    ),
    outsideDaysVisible: false,
    todayTextStyle: TextStyle(color: Colors.black),
  );

  late DateTime _focusedDay;
  Map<DateTime, List<Event>> _events = {};
  List<Course>? _courseList = [];

  List<Event> _getEventsForDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);

    return _events[key] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDay;
    fetchData();
  }

  Future<void> fetchData() async {
    String? coupleId = await _coupleService.findMyCoupleId(FirebaseAuth.instance.currentUser!.uid); //TODO. 임시. 나중에 로그인 할 때 객체 상태로 coupleId 가지고 있기.
    if (coupleId != null) {
      List<Course>? courseList = await _courseService.readCoursesByCoupleId(coupleId);
      if(courseList != null) {
        widget.onCoursesLoaded(courseList);
      }
      setState(() {
        _courseList = courseList;
        _events = buildEventMap(courseList!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TableCalendar(
          calendarStyle: _decoTableCalendarStyle,
          availableGestures: AvailableGestures.horizontalSwipe,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
          locale: 'ko_KR',
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2060, 3, 14),
          focusedDay: _focusedDay,

          eventLoader: _getEventsForDay,

          selectedDayPredicate: (day) {
            return isSameDay(widget.selectedDay, day);
          },

          onDaySelected: (selectedDay, focusedDay) {
            widget.onSelectDay(selectedDay);
            setState(() {
              _focusedDay = focusedDay;
            });
          },

          onPageChanged: (newFocusedDay) {
            setState(() {
              _focusedDay = newFocusedDay;
            });
          },
        ),
      ),
    );
  }
}
