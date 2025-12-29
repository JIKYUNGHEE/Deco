import 'package:flutter/material.dart';

class DecoCard extends StatelessWidget {
  final Widget child;
  const DecoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 380),
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            blurRadius: 28,
            offset: Offset(0, 18),
            color: Color(0x1A000000),
          ),
        ],
      ),
      child: child,
    );
  }
}