import 'package:deco/ui/core/themes/deco_theme_extension.dart';
import 'package:deco/ui/core/widgets/deco_press_scale.dart';
import 'package:flutter/material.dart';

class DecoPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double radius;
  final double fontSize;

  final Widget? prefixIcon;

  const DecoPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 52,
    this.radius = 14,
    this.fontSize = 16,
    this.prefixIcon,
  });

  bool get _enabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final disabled = !_enabled;
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>();

    return DecoPressScale(
      enabled: _enabled,
      pressedScale: 1.02,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: disabled ? null : decoTheme!.primaryGradient,
            color: disabled ? decoTheme!.disabledBg : null,
            boxShadow: const [
              BoxShadow(
                blurRadius: 16,
                offset: Offset(0, 10),
                color: Color(0x1A000000),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: _enabled ? onPressed : null,
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                      children: [
                        if(prefixIcon != null) ... [
                          IconTheme(data: const IconThemeData(size: 20, color: Colors.white), child: prefixIcon!),
                          const SizedBox(width: 8,),
                        ],
                        Text(
                            label,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w700,
                              color: disabled ? decoTheme!.disabledText : Colors.white,
                            ),
                          ),
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
