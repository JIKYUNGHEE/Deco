import 'package:deco/ui/core/widgets/deco_outlined_button.dart';
import 'package:deco/ui/core/widgets/deco_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseCtaSection extends StatelessWidget {
  final Future<void> Function() onCreated;

  const CourseCtaSection({super.key, required this.onCreated });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoPrimaryButton(
          label: '새 코스 만들기',
          onPressed: () async {
            final created = await context.push<bool>('/create-course');

            if(created == true) {
              await onCreated();
            }
          },
          height: 52,
          radius: 20,
        ),
        SizedBox(height: 8),
        // DecoPrimaryButton(
        //   prefixIcon: Icon(Icons.pin_drop_outlined),
        //   label: '우리 코스 전체 지도 보기',
        //   onPressed: () {},
        //   height: 52,
        //   radius: 20,
        // ),
      ],
    );
  }
}
