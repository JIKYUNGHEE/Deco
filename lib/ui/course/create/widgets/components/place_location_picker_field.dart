
import 'package:flutter/material.dart';

import '../../../../core/widgets/deco_outlined_button.dart';

class PlaceLocationPickerField extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;

  const PlaceLocationPickerField({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: DecoOutlinedButton(
        label: label == null ? '지도에서 위치 선택' : '📍 $label',
        onPressed: onTap,
        height: 52,
        radius: 14,
        borderWidth: 1.2,
        fontSize: 15,
        variant: DecoOutlinedVariant.subtle,
      ),
    );
  }
}