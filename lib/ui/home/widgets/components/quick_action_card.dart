import 'package:deco/ui/home/widgets/components/wobble_icon_tile.dart';
import 'package:flutter/material.dart';

import 'gradient_icon_tile.dart';

///“새 코스 만들기/달력보기/공개 코스” 같은 빠른 액션 카드.
class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Color> iconGradient;
  final bool selected;
  final VoidCallback? onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.iconGradient,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(26);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: r,
          border: Border.all(
            color: selected
                ? iconGradient.first.withValues(alpha: 0.85)
                : Colors.transparent,
            width: 1,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 30,
              offset: const Offset(0, 18),
            ),
            if (selected)
              BoxShadow(
                color: iconGradient.first.withValues(alpha: 0.28),
                blurRadius: 26,
                offset: const Offset(0, 12),
              ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
        child: Column(
          children: [
            WobbleIconTile(
              degrees: 8,
              onTap: onTap,
              child: GradientIconTile(
              icon: icon,
              colors: iconGradient,
              size: 64,
              radius: 20,
            ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.black.withValues(alpha: 0.75),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
