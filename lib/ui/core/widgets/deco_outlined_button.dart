import 'package:deco/ui/core/widgets/deco_press_scale.dart';
import 'package:flutter/material.dart';

import '../themes/deco_theme_extension.dart';

enum DecoOutlinedVariant { normal, subtle }

class DecoOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double radius;

  final double borderWidth;
  final double fontSize;
  final Color? textColor;

  final Widget? suffixIcon;

  final DecoOutlinedVariant variant;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? pressedBorderColor;

  const  DecoOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 52,
    this.radius = 14,
    this.borderWidth = 1.2,
    this.fontSize = 16,
    this.textColor,
    this.suffixIcon,
    this.variant = DecoOutlinedVariant.normal,
    this.backgroundColor,
    this.borderColor,
    this.pressedBorderColor,
  });

  bool get _enabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final disabled = !_enabled;
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    final baseTextColor = (variant == DecoOutlinedVariant.subtle)
        ? decoTheme.textSecondary
        : decoTheme.textPrimary;

    final foregroundColor = WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) return decoTheme.disabledText;
      if (states.contains(WidgetState.pressed)) return decoTheme.textPressed;
      return baseTextColor;
    });

    final side = WidgetStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(color: decoTheme.disabledBg, width: borderWidth);
      }
      if (states.contains(WidgetState.pressed)) {
        return BorderSide(color: decoTheme.outlinePressed, width: borderWidth);
      }
      return BorderSide(color: decoTheme.outlineColor, width: borderWidth);
    });

    final overlayColor = WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return null;

      if (states.contains(WidgetState.pressed)) {
        return decoTheme.overlayBase.withOpacity(0.08);
      }
      if (states.contains(WidgetState.hovered)) {
        return decoTheme.overlayBase.withOpacity(0.05);
      }
      if (states.contains(WidgetState.focused)) {
        return decoTheme.overlayBase.withOpacity(0.06);
      }
      return null;
    });

    return DecoPressScale(
      enabled: _enabled,
      pressedScale: 1.02,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: OutlinedButton(
          onPressed: _enabled ? onPressed : null,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.disabled)) return Colors.white;
              return backgroundColor ?? Colors.white;
            }),
            foregroundColor: foregroundColor,
            side: side,
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        color: disabled ? decoTheme.disabledText : baseTextColor,
                      ),
                    ),
                    if (suffixIcon != null) ...[
                      const SizedBox(width: 6),
                      IconTheme(
                        data: IconThemeData(
                          color: foregroundColor.resolve(
                            disabled ? {WidgetState.disabled} : {},
                          ),
                        ),
                        child: suffixIcon!,
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
