import 'package:flutter/material.dart';

class SectionBadgeIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color color;
  final double radius;
  final bool shadow;

  const SectionBadgeIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 40,
    this.iconSize = 22,
    this.radius = 18,
    this.shadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
        boxShadow: shadow
            ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ]
            : null,
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: iconSize,
        color: Colors.white.withValues(alpha: 0.95),
      ),
    );
  }
}
