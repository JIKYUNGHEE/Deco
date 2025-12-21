import 'package:flutter/material.dart';
import '../themes/deco_theme_extension.dart';

class DecoTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? errorText;
  final int maxLines;
  final VoidCallback? onTap;

  const DecoTextField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.errorText,
    this.maxLines = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 52,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            enabled: enabled,
            keyboardType: keyboardType,
            maxLines: maxLines,
            onTap: onTap,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: enabled ? decoTheme.textPrimary : decoTheme.disabledText,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: decoTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),

              suffixIcon: suffixIcon,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: decoTheme.outlineColor,
                  width: 1.4,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: decoTheme.outlinePressed,
                  width: 1.6,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: decoTheme.error,
                  width: 1.6,
                ),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: decoTheme.error,
                  width: 1.8,
                ),
              ),

              errorText: null,

              filled: true,
              fillColor: enabled
                  ? Colors.white
                  : decoTheme.disabledBg.withOpacity(0.6),
            ),
          ),
        ),

        if (hasError) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText!,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: decoTheme.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
