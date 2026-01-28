import 'package:deco/ui/core/widgets/deco_card.dart';
import 'package:deco/ui/mypage/components/field_label.dart';
import 'package:flutter/material.dart';

import '../profile_edit_screen.dart';

class CoupleNicknameSection extends StatelessWidget {
  const CoupleNicknameSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '커플 닉네임',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          const Text('내 닉네임'),
          const SizedBox(height: 6),
          TextFormField(
            decoration: inputDecoration(hint: ''),
          ),
          const SizedBox(height: 12),
          const Text('상대방 닉네임'),
          const SizedBox(height: 6),
          TextFormField(
            decoration: inputDecoration(hint: ''),
          ),
          const SizedBox(height: 6),
          const Text('앱에서 보일 서로의 닉네임을 설정하세요',
              style: TextStyle(fontSize: 12, color: Color(0xFF9B9B9B))),
        ],
      ),
    );
  }
}