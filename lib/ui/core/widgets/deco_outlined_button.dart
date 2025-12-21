import 'package:flutter/material.dart';

import '../themes/deco_theme_extension.dart';

class DecoOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double radius;

  final double borderWidth;
  final double fontSize;

  const DecoOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 52,
    this.radius = 14,
    this.borderWidth = 1.2,
    this.fontSize = 16,
  });

  bool get _enabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final disabled = !_enabled;
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>();

    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
          onPressed: _enabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF111827),
            side: BorderSide(
              color: disabled ? decoTheme!.disabledBg : decoTheme!.outlineColor,
              width: borderWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: isLoading ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2,),
          ) : Text(label, style: TextStyle(fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: disabled ? decoTheme.disabledText : const Color(
                  0xFF111827)),)

      ),
    );
  }
}
