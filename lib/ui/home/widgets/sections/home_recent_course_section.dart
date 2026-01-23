import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../components/section_badge_icon.dart';
import '../components/section_header.dart';

class HomeRecentCourseSection extends StatelessWidget {
  const HomeRecentCourseSection({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onTapAll,
  });

  final int itemCount;
  final Widget Function(BuildContext, int, double cardWidth) itemBuilder;
  final VoidCallback? onTapAll;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;
    final cardWidth = screenW - 40 - 12;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SectionHeader(
              leading: const SectionBadgeIcon(
                icon: Icons.trending_up_outlined,
                color: AppColors.primary,
              ),
              title: '최근 데이트 코스',
              trailing: _AllButton(onTap: onTapAll),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 380,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 20),
              itemCount: itemCount,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: cardWidth,
                  child: itemBuilder(context, index, cardWidth),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AllButton extends StatelessWidget {
  const _AllButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(18);

    return ClipRRect(
      borderRadius: r,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: r,
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  Text(
                    '전체보기',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: AppColors.primary.withValues(alpha: 0.9),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
