import 'package:flutter/material.dart';

import '../../../../../domain/models/course.dart';
import '../../components/course_card.dart';

class CourseListSection extends StatelessWidget {
  final List<Course>? courseList;

  const CourseListSection({super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '코스 목록',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ),
            Text(
              '총 ${courseList?.length ?? 0}개',
              style: textTheme.labelMedium?.copyWith(
                color: Colors.black.withValues(alpha: 0.55),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8,),
        if(courseList != null)
          ListView.separated(
            primary: false,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courseList?.length ?? 0,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => CourseCard(data: courseList![i], onTap: () {}),
          ),

      ],
    );
  }
}
