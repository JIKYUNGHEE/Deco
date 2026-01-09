import 'package:flutter/material.dart';

import '../../components/course_card.dart';

class CourseListSection extends StatelessWidget {
  const CourseListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      4,
      (i) => CourseCardData(
        title: ['홍대 감성 데이트', '주말 한강 피크닉', '북촌 한옥마을 산책', '이촌 드라이브'][i],
        dateText: ['2026.04.06', '2025.04.05', '2025.04.01', '2025.03.28'][i],
        routeText: '카페 → 전시 → 파스타집',
        likes: 8 + i,
        photos: 3 + i,
      ),
    );

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
              '총 ${items.length}개',
              style: textTheme.labelMedium?.copyWith(
                color: Colors.black.withValues(alpha: 0.55),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8,),
        ListView.separated(
          primary: false,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => CourseCard(data: items[i], onTap: () {}),
        )
      ],
    );
  }
}
