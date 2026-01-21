import 'package:flutter/material.dart';

import '../components/photo_picker_grid.dart';

class CreatePlacePhotosSection extends StatefulWidget {
  final List<ImageProvider?> photos;
  final void Function(int index) onTapPickAt;

  const CreatePlacePhotosSection({
    super.key,
    required this.photos,
    required this.onTapPickAt,
  });

  @override
  State<CreatePlacePhotosSection> createState() => _CreatePlacePhotosSectionState();
}

class _CreatePlacePhotosSectionState extends State<CreatePlacePhotosSection> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('사진 (선택)', style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        PhotoPickerGrid(
          photos: widget.photos,
          onTapPickAt: widget.onTapPickAt,
        ),
        const SizedBox(height: 8),
        Text(
          '사진은 이 장소에서의 기억을 남기기 위한 용도예요',
          style: textTheme.labelMedium?.copyWith(
            color: Colors.black.withValues(alpha: 0.45),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}