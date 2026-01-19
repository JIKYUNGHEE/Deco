import 'package:deco/ui/core/widgets/deco_text_field.dart';
import 'package:flutter/material.dart';

import '../components/place_location_picker_field.dart';
import '../components/place_type_selector.dart';

enum PlaceType {
  cafe('카페'), restaurant('식당'), park('공원'), exhibit('전시'), walk('산책'), movie('영화'), other('기타');

  final String name;
  const PlaceType(this.name);
}

class CreatePlaceBasicInfoSection extends StatelessWidget {
  final TextEditingController nameController;

  final PlaceType? selectedType;
  final ValueChanged<PlaceType> onSelectType;

  final String? locationLabel;
  final VoidCallback? onTapPickLocation;

  const CreatePlaceBasicInfoSection({
    super.key,
    required this.nameController,
    required this.selectedType,
    required this.onSelectType,
    required this.locationLabel,
    required this.onTapPickLocation,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '장소 이름',
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        DecoTextField(controller: nameController, hintText: '(예) 카페 이름'),

        Text(
          '장소 타입',
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        PlaceTypeSelector(selected: selectedType, onSelect: onSelectType),

        const SizedBox(height: 8),
        Text(
          '장소의 대표적인 성격 하나만 골라주세요',
          style: textTheme.labelMedium?.copyWith(
            color: Colors.black.withValues(alpha: 0.45),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),

        Text(
          '위치',
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        PlaceLocationPickerField(
          label: locationLabel,
          onTap: onTapPickLocation,
        ),
      ],
    );
  }
}
