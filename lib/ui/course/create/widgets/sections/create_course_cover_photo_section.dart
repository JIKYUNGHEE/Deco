import 'package:deco/ui/core/widgets/deco_primary_button.dart';
import 'package:flutter/material.dart';

class CreateCourseCoverPhotoSection extends StatelessWidget {
  const CreateCourseCoverPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('대표 사진 선택'),
        Stack(
          children: [
            Container(),
            DecoPrimaryButton(prefixIcon: Icon(Icons.add), label: '사진 추가', onPressed: (){}),
          ],
        ),
      ],
    );
  }

}