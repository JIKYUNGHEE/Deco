import 'package:deco/ui/core/widgets/deco_text_field.dart';
import 'package:flutter/material.dart';

class CreateCourseBasicInfoSection extends StatelessWidget {
  const CreateCourseBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('제목'),
        DecoTextField(),
        Text('날짜'),
        DecoTextField(),
      ],
    );
  }

}