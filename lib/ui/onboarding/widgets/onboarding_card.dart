import 'package:flutter/material.dart';

class OnboardingCard extends StatelessWidget {
  final Widget content;
  final Widget? bottom;

  const OnboardingCard({super.key, required this.content, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 28,
                  offset: Offset(0, 18),
                  color: Color(0x1A000000),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                content,
                if (bottom != null) ...[const SizedBox(height: 18), bottom!],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
