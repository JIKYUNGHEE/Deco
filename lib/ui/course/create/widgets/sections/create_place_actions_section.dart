import 'package:deco/ui/core/widgets/deco_outlined_button.dart';
import 'package:deco/ui/core/widgets/deco_primary_button.dart';
import 'package:flutter/material.dart';

class CreatePlaceActionsSection extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSave;

  const CreatePlaceActionsSection({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoOutlinedButton(
            label: '취소',
            onPressed: onCancel,
            height: 52,
            radius: 999,
            borderWidth: 1.4,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DecoPrimaryButton(
            label: '저장',
            onPressed: onSave,
            height: 52,
            radius: 999,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
