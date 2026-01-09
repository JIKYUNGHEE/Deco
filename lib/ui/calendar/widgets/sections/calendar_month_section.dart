import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMonthSection extends StatefulWidget {
  const CalendarMonthSection({super.key});

  @override
  State<CalendarMonthSection> createState() => _CalendarMonthSectionState();
}

class Event {
  String title;
  Event(this.title);
}

Map<DateTime,List<Event>> events = {
  DateTime(2026, 1, 9): [
    Event('야경 드라이브'),
    Event('야경 드라이브'),
    Event('야경 드라이브'),
  ],
  DateTime(2026, 01, 12): [
    Event('홍대 데이트'),
  ],
};

List<Event> _getEventsForDay(DateTime day) {
  final key = DateTime(day.year, day.month, day.day);
  return events[key] ?? [];
}

class _CalendarMonthSectionState extends State<CalendarMonthSection> {
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
        shape: BoxShape.circle
    ),
    outsideDaysVisible: false,
    todayTextStyle: TextStyle(color: Colors.black),
  );

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

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
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,

          eventLoader: _getEventsForDay,

          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },

          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
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
