import 'package:flutter/material.dart';

import '../../../../core/themes/deco_theme_extension.dart';

class EmptyPlacesHint extends StatelessWidget {
  const EmptyPlacesHint({super.key});

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(18);
    final textTheme = Theme.of(context).textTheme;
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    final border = decoTheme.primaryGradient.colors.first.withValues(
      alpha: 0.55,
    );
    final fill = decoTheme.primaryGradient.colors.first.withValues(alpha: 0.10);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        borderRadius: r,
        color: fill,
        border: Border.all(color: border, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.place_outlined, size: 26, color: border),
          const SizedBox(height: 8),
          Text(
            '아직 추가된 장소가 없어요',
            style: textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.black.withValues(alpha: 0.70),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '아래 버튼을 눌러 장소를 추가해보세요!',
            style: textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black.withValues(alpha: 0.45),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
