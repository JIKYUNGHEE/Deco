import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CharacterPreview extends StatelessWidget {
  final String assetPath;
  const CharacterPreview({required this.assetPath});


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 96,
          height: 96,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0EC),
            borderRadius: BorderRadius.circular(34),
            boxShadow: const [
              BoxShadow(
                blurRadius: 18,
                offset: Offset(0, 10),
                color: Color(0x1A000000),
              ),
            ],
          ),
          child: SvgPicture.asset(assetPath, fit: BoxFit.contain),
        ),
        Positioned(
          right: -6,
          bottom: -6,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 14,
                  offset: Offset(0, 8),
                  color: Color(0x1A000000),
                ),
              ],
            ),
            child: const Icon(Icons.edit, size: 18, color: Color(0xFFFF4FA3)),
          ),
        ),
      ],
    );
  }
}