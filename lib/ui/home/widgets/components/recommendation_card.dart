import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';

///오늘의 추천 카드(추천 코스/장소/콘텐츠 등을 보여줌).
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(28);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: r,
        color: const Color(0xFFEDE1FF).withValues(alpha: 0.55),
        border: Border.all(
          color: const Color(0xFFCDB5FF).withValues(alpha: 0.55),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 26,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: r,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white.withValues(alpha: 0.45),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.65),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 24,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withValues(alpha: 0.70),
                                  Colors.black.withValues(alpha: 0.10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 14,
                        top: 14,
                        child: _Pill(
                          text: 'HOT',
                          colors: const [Color(0xFF7C3AED), Color(0xFFA78BFA)],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Pill(
                      text: '공개 코스',
                      colors: [AppColors.secondary, AppColors.primary],
                    ),
                    const SizedBox(height: 14),

                    Text(
                      '홍대 감성 데\n이트',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.gray900,
                        height: 1.08,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: const Color(0xFF7C3AED).withValues(alpha: 0.75),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '카페 → 전시 → 파스타',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.gray700,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          size: 18,
                          color: Colors.black.withValues(alpha: 0.40),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '지민 & 수현',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withValues(alpha: 0.55),
                            height: 1.1,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.favorite_rounded,
                          size: 18,
                          color: const Color(0xFFFF4FA3).withValues(alpha: 0.85),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '128',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.black.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 170),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.10),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Text(
                          '💬 "홍대 데이트의 정석! 감성 충만한 하루"',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray700,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final List<Color> colors;

  const _Pill({
    required this.text,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
