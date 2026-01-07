import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        leading,
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: const Color(0xFF111827),
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
