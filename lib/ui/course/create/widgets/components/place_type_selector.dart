import 'package:flutter/material.dart';

import '../sections/create_place_basic_info_section.dart';

class PlaceTypeSelector extends StatelessWidget {
  final PlaceType? selected;
  final ValueChanged<PlaceType> onSelect;

  const PlaceTypeSelector({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_TypeItem>[
      _TypeItem(PlaceType.cafe, '카페', '☕️'),
      _TypeItem(PlaceType.restaurant, '식당', '🍽️'),
      _TypeItem(PlaceType.park, '공원', '🌳'),
      _TypeItem(PlaceType.exhibit, '전시', ' 🎨'),
      _TypeItem(PlaceType.walk, '산책', '🚶‍♀️'),
      _TypeItem(PlaceType.movie, '영화', '🎬'),
      _TypeItem(PlaceType.other, '기타', '+'),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:items.map((e) {
        final isSel = e.type == selected;

        return _Chip(
          label: e.label,
          emoji: e.emoji,
          selected: isSel,
          onTap: () => onSelect(e.type),
        );
      }).toList(),
    );
  }
}

class _TypeItem {
  final PlaceType type;
  final String label;
  final String emoji;
  _TypeItem(this.type, this.label, this.emoji);
}

class _Chip extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(12);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF2E7FF) : Colors.white,
          borderRadius: r,
          border: Border.all(
            color: selected
                ? const Color(0xFFB58BFF)
                : Colors.black.withValues(alpha: 0.10),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.black.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}