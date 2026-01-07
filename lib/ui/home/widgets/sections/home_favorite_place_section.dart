import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../components/place_card.dart';
import '../components/section_badge_icon.dart';
import '../components/section_header.dart';

class HomeFavoritePlaceSection extends StatelessWidget {
  const HomeFavoritePlaceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            leading: SectionBadgeIcon(
              icon: Icons.workspace_premium_outlined,
              color: AppColors.secondary,
            ),
            title: '자주 가는 장소',
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(
                child: PlaceCard(
                  title: '카페 OO',
                  category: '카페',
                  count: 12,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: PlaceCard(
                  title: '한강공원',
                  category: '공원',
                  count: 8,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: PlaceCard(
                  title: '파스타집 △△',
                  category: '레스토랑',
                  count: 7,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
