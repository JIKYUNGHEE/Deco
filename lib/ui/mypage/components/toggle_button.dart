import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;


  const ToggleButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFE0EC) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? const Color(0xFFFF4FA3) : const Color(0xFFE9E9EE),
            width: selected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: selected ? const Color(0xFFFF4FA3) : const Color(0xFF4A4A4A),
            ),
          ),
        ),
      ),
    );
  }
}