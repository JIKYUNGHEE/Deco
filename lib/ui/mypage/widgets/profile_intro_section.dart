import 'package:deco/ui/core/widgets/deco_card.dart';
import 'package:flutter/material.dart';

import '../profile_edit_screen.dart';

class ProfileIntroSection extends StatelessWidget {
  final TextEditingController introController;

  const ProfileIntroSection({super.key, required this.introController});

  @override
  Widget build(BuildContext context) {
    return DecoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '소개',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),

          TextFormField(
            controller: introController,
            maxLines: 4,
            maxLength: 100,
            decoration: inputDecoration(hint: '자신을 소개하는 한 문장을 작성해보세요'),
          ),
          const SizedBox(height: 6),
          Text(
            '최대 100자까지 입력 가능합니다',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: const Color(0xFF9B9B9B)),
          ),
        ],
      ),
    );
  }
}
