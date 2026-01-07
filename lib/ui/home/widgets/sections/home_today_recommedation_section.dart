import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../components/recommendation_card.dart';
import '../components/section_badge_icon.dart';
import '../components/section_header.dart';

class HomeTodayRecommendationSection extends StatelessWidget {
  const HomeTodayRecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            leading: SectionBadgeIcon(
              icon: Icons.auto_awesome_outlined,
              color: AppColors.secondary,
            ),
            title: '오늘의 추천',
          ),
          const SizedBox(height: 14),
          const RecommendationCard(),
        ],
      ),
    );
  }
}
