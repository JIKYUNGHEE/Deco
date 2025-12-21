import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingDots extends StatelessWidget {
  final int index;
  final int count;
  final ValueChanged<int>? onDotTap;

  const OnboardingDots({
    super.key,
    required this.index,
    this.count = 3,
    this.onDotTap,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final selected = i == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: onDotTap == null ? null : () => onDotTap!(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              height: 6,
              width: selected ? 20 : 6,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.gray300,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        );
      }),
    );
  }
}
