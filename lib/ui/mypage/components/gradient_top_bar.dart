import 'package:flutter/material.dart';

class GradientTopBar extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final VoidCallback onBack;
  final VoidCallback onSave;

  const GradientTopBar({
    required this.gradient,
    required this.title,
    required this.onBack,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 6, 12, 12),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.chevron_left, color: Colors.white),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              _SavePillButton(onTap: onSave),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavePillButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SavePillButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              blurRadius: 14,
              offset: Offset(0, 8),
              color: Color(0x1A000000),
            ),
          ],
        ),
        child: const Text(
          '저장',
          style: TextStyle(
            color: Color(0xFF7A3CFF),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}