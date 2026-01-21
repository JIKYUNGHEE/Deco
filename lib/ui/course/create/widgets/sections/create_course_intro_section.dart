import 'package:flutter/material.dart';

import '../../../../auth/bear_in_love_illustration.dart';

class CreateCourseIntroSection extends StatelessWidget {
  const CreateCourseIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BearInLoveIllustration(),
        Text('새로운 데이트 추억을 기록해보세요!✨'),
      ],
    );
  }
}
