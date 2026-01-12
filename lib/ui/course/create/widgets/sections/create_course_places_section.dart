import 'package:deco/ui/core/widgets/deco_outlined_button.dart';
import 'package:flutter/material.dart';

class CreateCoursePlacesSection extends StatelessWidget {
  const CreateCoursePlacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('장소들'),
        Container(),
        DecoOutlinedButton(label: '장소 추가', onPressed: (){}),
      ],
    );
  }

}