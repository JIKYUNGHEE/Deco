import 'package:flutter/material.dart';

import '../components/character_preview.dart';
import '../components/color_picker_row.dart';
import '../profile_edit_screen.dart';

class ProfileCharacterSection extends StatelessWidget {
  final BearColor selected;
  final ValueChanged<BearColor> onSelect;

  const ProfileCharacterSection({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 14),
          Text(
            '프로필 캐릭터',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),

          CharacterPreview(assetPath: selected.assetPath),
          const SizedBox(height: 14),

          Text(
            '캐릭터 색상',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),

          ColorPickerRow(
            selected: selected,
            onSelect: onSelect,
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}