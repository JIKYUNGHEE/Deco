import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../domain/models/course.dart';
import '../../components/course_card.dart';

class CourseListSection extends StatelessWidget {
  final List<Course>? courseList;
  final bool isSharedCourse;

  const CourseListSection({super.key, required this.courseList, this.isSharedCourse = false});

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
            itemBuilder: (_, i) => CourseCard(data: courseList![i], onTap: () {
              context.push(
                '/course/detail',
                extra: {
                  'course': courseList![i],
                  'isShared': isSharedCourse,
                }
              );
            }),
          ),

      ],
    );
  }
}
