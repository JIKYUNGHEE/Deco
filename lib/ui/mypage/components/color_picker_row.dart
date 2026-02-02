import 'package:flutter/material.dart';

import '../profile_edit_screen.dart';

class ColorPickerRow extends StatelessWidget {
  final BearColor selected;
  final ValueChanged<BearColor> onSelect;


  const ColorPickerRow({
    required this.selected,
    required this.onSelect,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: BearColor.values.map((c) {
        final isSelected = c == selected;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(c),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFFFF4FA3) : const Color(0xFFE9E9EE),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? const [
                  BoxShadow(
                    blurRadius: 14,
                    offset: Offset(0, 8),
                    color: Color(0x14000000),
                  )
                ]
                    : null,
              ),
              child: Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: c.swatch,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    c.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF4A4A4A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}