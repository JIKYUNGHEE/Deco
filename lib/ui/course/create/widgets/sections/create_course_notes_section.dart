import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:deco/ui/core/widgets/deco_text_field.dart';
import 'package:flutter/material.dart';

class CreateCourseNotesSection extends StatelessWidget {
  final TextEditingController oneLineController;
  final TextEditingController memoController;

  final bool isPublic;
  final ValueChanged<bool> onChangedPublic;

  const CreateCourseNotesSection({
    super.key,
    required this.oneLineController,
    required this.memoController,
    required this.isPublic,
    required this.onChangedPublic,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '그날의 한 문장',
          style: textTheme.labelLarge?.copyWith(
            color: Colors.black.withValues(alpha: 0.70),
            fontWeight: FontWeight.w800,
          ),
        ),
        DecoTextField(
          maxLines: 1,
          controller: oneLineController,
          hintText: '이날의 감정을 짧게 남겨보세요.',
        ),
        SizedBox(height: 8),

        Text(
          '코스 메모',
          style: textTheme.labelLarge?.copyWith(
            color: Colors.black.withValues(alpha: 0.70),
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.10),
              width: 1.2,
            ),
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
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '전체 코스에 대한 메모를 남겨보세요.',
              hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.35)),
            ),
            controller: memoController,
          ),
        ),

        SizedBox(height: 16),

        Row(
          children: [
            Text(
              '공개 여부',
              style: textTheme.labelLarge?.copyWith(
                color: Colors.black.withValues(alpha: 0.70),
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Transform.scale(
                scale: 0.95,
                child: Switch(
                  value: isPublic,
                  onChanged: onChangedPublic,
                  activeTrackColor: AppColors.primary,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.black.withValues(alpha: 0.02),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
