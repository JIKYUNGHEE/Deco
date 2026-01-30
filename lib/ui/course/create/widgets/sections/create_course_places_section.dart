import 'package:deco/domain/models/place.dart';
import 'package:deco/ui/core/widgets/deco_outlined_button.dart';
import 'package:deco/ui/course/create/widgets/components/selected_place_chip.dart';
import 'package:flutter/material.dart';

import '../components/empty_places_hint.dart';

class CreateCoursePlacesSection extends StatelessWidget {
  final List<Place> places;
  final VoidCallback? onTapAddPlace;
  final ValueChanged<int>? onRemovePlace;

  const CreateCoursePlacesSection({
    super.key,
    required this.places,
    this.onTapAddPlace,
    this.onRemovePlace,
  });

  bool get _isEmpty => places.isEmpty;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '장소들',
          style: textTheme.labelLarge?.copyWith(
            color: Colors.black.withValues(alpha: 0.70),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),

        if (_isEmpty)
          const EmptyPlacesHint()
        else
          Column(
            children: List.generate(places.length, (index) {
              final place = places[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: SelectedPlaceChip(
                  index: index + 1,
                  title: place.name!,
                  tag: place.type!,
                  location: place.address!,
                  onRemove: onRemovePlace == null
                      ? null
                      : () => onRemovePlace!(index),
                ),
              );
            }),
          ),
        SizedBox(height: 8,),
        SizedBox(
          height: 52,
          child: DecoOutlinedButton(
            label: '+ 장소 추가',
            onPressed: onTapAddPlace,
            height: 52,
            radius: 999,
            borderWidth: 1.4,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}