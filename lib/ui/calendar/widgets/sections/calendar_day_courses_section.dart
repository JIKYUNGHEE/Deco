import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import 'calendar_month_section.dart';

class CalendarDayCoursesSection extends StatelessWidget {
  final DateTime selectedDay;
  final Map<DateTime, List<Event>> events;

  const CalendarDayCoursesSection({
    super.key,
    required this.selectedDay,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final key = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    final dayEvents = events[key] ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '이 날의 코스',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          if (dayEvents.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.surface,
              ),
              child: Text(
                '이 날은 아직 코스가 없어요.',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray500,
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: dayEvents.length,
              itemBuilder: (context, index) {
                final event = dayEvents[index];
                final course = event.course;
                final title = course.title ?? '제목 없는 데이트';
                final isPublic = course.isPublic == true;

                final placesText = (course.places == null || course.places!.isEmpty)
                    ? ''
                    : course.places!
                    .map((p) => p.name ?? '')
                    .where((name) => name.isNotEmpty)
                    .join(' → ');

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    height: 104,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: isPublic ? Color(0xFFDCFCE7) : Color(0xFFF3F4F6),
                                ),
                                child: Text(
                                  isPublic ? '공개' : '비공개',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isPublic ? Color(0xFF008236) : Color(0xFF6B7280),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            placesText.isEmpty ? '장소가 아직 없어요.' : placesText,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.gray500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
