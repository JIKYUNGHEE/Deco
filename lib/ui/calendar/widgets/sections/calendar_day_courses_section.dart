import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';

class CalendarDayCoursesSection extends StatelessWidget {
  const CalendarDayCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: 2,
            itemBuilder: (context, index) {
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
                                '야경 드라이브',
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
                                color: Color(0xFFDCFCE7),
                              ),
                              child: Text(
                                '공개',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF008236),
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          '드라이브 → 전망대 → 야식',
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
