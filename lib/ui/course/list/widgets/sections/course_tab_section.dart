import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/deco_theme_extension.dart';
import '../../../../core/widgets/deco_outlined_button.dart';

enum CourseTab { my, public }

class CourseTabSection extends StatelessWidget {
  final CourseTab current;
  final ValueChanged<CourseTab> onChanged;

  const CourseTabSection({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    Widget tabBtn({
      required String label,
      required bool selected,
      required VoidCallback onPressed,
    }) {
      final accent = AppColors.primary;

      return DecoOutlinedButton(
        label: label,
        height: 44,
        radius: 18,
        fontSize: 14,
        borderWidth: 1.4,
        onPressed: onPressed,

        backgroundColor:
        selected ? accent.withValues(alpha: 0.12) : Colors.white,
        borderColor:
        selected ? accent.withValues(alpha: 0.35) : decoTheme.outlineColor,
        pressedBorderColor: accent.withValues(alpha: 0.55),
        textColor: selected ? accent : decoTheme.textSecondary,
        variant: selected ? DecoOutlinedVariant.normal : DecoOutlinedVariant.subtle,
      );
    }

    return Row(
      children: [
        Expanded(
          child: tabBtn(
            label: '우리 코스',
            selected: current == CourseTab.my,
            onPressed: () => onChanged(CourseTab.my),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: tabBtn(
            label: '공개 코스',
            selected: current == CourseTab.public,
            onPressed: () => onChanged(CourseTab.public),
          ),
        ),
      ],
    );
  }
}