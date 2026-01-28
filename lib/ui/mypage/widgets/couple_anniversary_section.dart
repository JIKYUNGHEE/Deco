import 'package:deco/ui/core/widgets/deco_card.dart';
import 'package:deco/ui/mypage/components/field_label.dart';
import 'package:flutter/material.dart';

import '../profile_edit_screen.dart';

class CoupleAnniversarySection extends StatelessWidget {
  const CoupleAnniversarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '기념일',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: inputDecoration(hint: ''),
          ),
          const SizedBox(height: 6),
          const Text('처음 만난 날이나 사귀기 시작한 날을 설정해요',
              style: TextStyle(fontSize: 12, color: Color(0xFF9B9B9B))),
        ],
      ),
    );
  }
}