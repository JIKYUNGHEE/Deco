import 'dart:ui';

import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

///“다음 데이트” 요약 카드
class NextDateCard extends StatelessWidget {
  final String label;
  final String dayText;
  final String message;

  const NextDateCard({
    super.key,
    this.label = '다음 데이트',
    this.dayText = '토요일',
    this.message = '설레는 주말이 다가오고 있어요!💘',
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(22);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        height: 124,
        decoration: BoxDecoration(
          borderRadius: r,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 26,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: r,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(gradient: AppColors.warmGradient),
                ),
              ),
              Positioned(
                left: -20,
                top: -30,
                child: IgnorePointer(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.14),
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 10,
                top: 10,
                bottom: 10,
                child: SizedBox(
                  width: 94,
                  child: _CalendarSheet(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 110, 14),
                child: _TextBlock(
                  label: label,
                  dayText: dayText,
                  message: message,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _TextBlock extends StatelessWidget {
  final String label;
  final String dayText;
  final String message;

  const _TextBlock({
    required this.label,
    required this.dayText,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.20),
                ),
              ),
              child: Icon(
                Icons.access_time_rounded,
                size: 14,
                color: Colors.white.withValues(alpha: 0.92),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: textTheme.labelMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.90),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Text(
          dayText,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            height: 1.05,
          ),
        ),
        Text(
          message,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.90),
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}


class _CalendarSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -10,
          bottom: -6,
          child: Opacity(
            opacity: 0.20,
            child: Text(
              '🗓️',
              style: const TextStyle(
                fontSize: 114,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
