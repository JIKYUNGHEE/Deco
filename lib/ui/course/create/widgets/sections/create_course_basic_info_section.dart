import 'package:deco/ui/core/widgets/deco_text_field.dart';
import 'package:flutter/material.dart';

class CreateCourseBasicInfoSection extends StatelessWidget {
  const CreateCourseBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '제목',
          style: textTheme.labelLarge?.copyWith(
            color: Colors.black.withValues(alpha: 0.70),
            fontWeight: FontWeight.w800,
          ),
        ),
        DecoTextField(hintText: '예) 주말 한강 피크닉',),
        SizedBox(height: 8,),
        Text(
          '날짜',
          style: textTheme.labelLarge?.copyWith(
            color: Colors.black.withValues(alpha: 0.70),
            fontWeight: FontWeight.w800,
          ),
        ),
        DecoTextField(hintText: '날짜 선택...',),
      ],
    );
  }
}
