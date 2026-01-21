import 'package:flutter/material.dart';

class PhotoPickerGrid extends StatelessWidget {
  final List<ImageProvider?> photos;
  final void Function(int index) onTapPickAt;

  const PhotoPickerGrid({
    super.key,
    required this.photos,
    required this.onTapPickAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (i) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i == 2 ? 0 : 10),
            child: _Cell(
              image: photos.length > i ? photos[i] : null,
              onTap: () => onTapPickAt(i),
            ),
          ),
        );
      }),
    );
  }
}

class _Cell extends StatelessWidget {
  final ImageProvider? image;
  final VoidCallback onTap;

  const _Cell({required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(14);

    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: Colors.white,
        borderRadius: r,
        child: InkWell(
          borderRadius: r,
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: r,
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.10),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: r,
              child: image == null
                  ? Center(
                child: Icon(
                  Icons.add_rounded,
                  size: 28,
                  color: Colors.black.withValues(alpha: 0.25),
                ),
              )
                  : Image(image: image!, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
