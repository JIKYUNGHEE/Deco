import 'package:flutter/material.dart';

import '../components/field_label.dart';
import '../components/toggle_button.dart';
import '../profile_edit_screen.dart';

class ProfilePersonalInfoSection extends StatelessWidget {
  final TextEditingController nicknameController;
  final TextEditingController birthController;

  final Gender gender;
  final ValueChanged<Gender> onGenderChanged;


  const ProfilePersonalInfoSection({
    super.key,
    required this.nicknameController,
    required this.birthController,
    required this.gender,
    required this.onGenderChanged,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '개인 정보',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),


            const FieldLabel('닉네임'),
            const SizedBox(height: 6),
            TextFormField(
              controller: nicknameController,
              decoration: inputDecoration(hint: '닉네임'),
              validator: (v) {
                final text = (v ?? '').trim();
                if (text.length < 2 || text.length > 10) {
                  return '2~10자 이내로 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 6),
            Text(
              '2~10자 이내로 입력해주세요',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF9B9B9B),
              ),
            ),
            const SizedBox(height: 12),


            const FieldLabel('생년월일'),
            const SizedBox(height: 6),
            TextFormField(
              controller: birthController,
              keyboardType: TextInputType.datetime,
              decoration: inputDecoration(hint: '예) 1997.04.01'),
            ),
            const SizedBox(height: 12),

            const FieldLabel('성별'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ToggleButton(
                    text: '남성',
                    selected: gender == Gender.male,
                    onTap: () => onGenderChanged(Gender.male),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ToggleButton(
                    text: '여성',
                    selected: gender == Gender.female,
                    onTap: () => onGenderChanged(Gender.female),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}