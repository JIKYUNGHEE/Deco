import 'package:flutter/material.dart';

class CreatePlaceMemoSection extends StatelessWidget {
  final TextEditingController controller;

  const CreatePlaceMemoSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final r = BorderRadius.circular(14);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('메모 (선택)', style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: r,
            border: Border.all(color: Colors.black.withValues(alpha: 0.10), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: TextField(
            controller: controller,
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '이 장소에 대한 특별한 기억을 적어보세요...',
              hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.35)),
            ),
          ),
        ),
      ],
    );
  }
}