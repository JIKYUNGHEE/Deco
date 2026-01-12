import 'package:deco/ui/core/widgets/deco_text_field.dart';
import 'package:flutter/material.dart';

class CreateCourseNotesSection extends StatelessWidget {
  const CreateCourseNotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('그날의 한 문장'),
        DecoTextField(maxLines: 1,),
        Text('코스 메모'),
        DecoTextField(hintText: '전체 코스에 대한 메모를 남겨 보세요.',),
      ],
    );
  }

}