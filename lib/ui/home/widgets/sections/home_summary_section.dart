import 'package:deco/ui/core/themes/deco_theme_extension.dart';
import 'package:deco/ui/home/widgets/components/wobble_icon_tile.dart';
import 'package:deco/ui/home/widgets/components/summary_stat_card.dart';
import 'package:flutter/material.dart';

import '../components/quick_action_card.dart';

class HomeSummarySection extends StatefulWidget {
  const HomeSummarySection({super.key});

  @override
  State<HomeSummarySection> createState() => _HomeSummarySectionState();
}

class _HomeSummarySectionState extends State<HomeSummarySection> {
  static const double headerHeight = 360;
  static const double quickCardHeight = 160;
  static const double quickCardOverlap = 90;

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    return SizedBox(
      height: headerHeight + (quickCardHeight - quickCardOverlap),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: headerHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: decoTheme.primaryGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '우리의 여정',
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.85,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '지민 & 수현',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Text(
                      '데이트 코스',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '우리만의 특별한 순간들✨',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 124,
                      child: Row(
                        children: const [
                          Expanded(
                            child: SummaryStatCard(
                              emoji: '💕',
                              title: '함께한 날',
                              value: 'D+365',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: SummaryStatCard(
                              emoji: '📍',
                              title: '총 코스',
                              value: '24개',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: SummaryStatCard(
                              emoji: '⭐',
                              title: '이달의 데이트',
                              value: '6회',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: -(quickCardHeight - quickCardOverlap),
            child: SizedBox(
              height: quickCardHeight,
              child: Row(
                children: [
                  Expanded(
                    child: QuickActionCard(
                      icon: Icons.add,
                      title: '새 코스\n만들기',
                      iconGradient: [Color(0xFFFF2FA0), Color(0xFFFF76C8)],
                      selected: _selectedIndex == 0,
                      onTap: () => setState(() => _selectedIndex = 0),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: QuickActionCard(
                      icon: Icons.calendar_month,
                      title: '달력\n보기',
                      iconGradient: [Color(0xFF6D33FF), Color(0xFFB69CFF)],
                      selected: _selectedIndex == 1,
                      onTap: () => setState(() => _selectedIndex = 1),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: QuickActionCard(
                      icon: Icons.share,
                      title: '공개\n코스',
                      iconGradient: [Color(0xFFC7A6FF), Color(0xFFE8DAFF)],
                      selected: _selectedIndex == 2,
                      onTap: () => setState(() => _selectedIndex = 2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
