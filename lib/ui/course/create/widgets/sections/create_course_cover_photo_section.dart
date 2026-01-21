import 'package:deco/ui/core/widgets/deco_primary_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/deco_outlined_button.dart';

class CreateCourseCoverPhotoSection extends StatelessWidget {
  final VoidCallback? onPickPhoto;
  final VoidCallback? onDeletePhoto;
  final ImageProvider? image;

  const CreateCourseCoverPhotoSection({
    super.key,
    this.onPickPhoto,
    this.onDeletePhoto,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '대표 사진 선택',
          style: textTheme.labelLarge?.copyWith(
            color: Colors.black.withValues(alpha: 0.70),
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 10),

        _CoverPhotoCard(
          image: image,
          onPickPhoto: onPickPhoto,
          onDeletePhoto: onDeletePhoto,
        ),
      ],
    );
  }
}

class _CoverPhotoCard extends StatelessWidget {
  final ImageProvider? image;
  final VoidCallback? onPickPhoto;
  final VoidCallback? onDeletePhoto;

  const _CoverPhotoCard({
    required this.image,
    required this.onPickPhoto,
    required this.onDeletePhoto,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(18);
    final textTheme = Theme.of(context).textTheme;

    return AspectRatio(
      aspectRatio: 16/9,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: r,
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.08),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: r,
          child: Stack(
            children: [
              if (image != null)
                Positioned.fill(
                  child: Image(image: image!, fit: BoxFit.cover),
                ),

              if (image == null)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 26,
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '이 코스를 대표하는 사진',
                        style: textTheme.labelMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.35),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

              Positioned(
                right: 12,
                bottom: 12,
                child: _AddPhotoButton(
                  hasImage: image != null,
                  onPickPhoto: onPickPhoto,
                  onDeletePhoto: onDeletePhoto,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPhotoButton extends StatelessWidget {
  final bool hasImage;
  final VoidCallback? onPickPhoto;
  final VoidCallback? onDeletePhoto;

  const _AddPhotoButton({
    required this.hasImage,
    required this.onPickPhoto,
    required this.onDeletePhoto,
  });

  @override
  Widget build(BuildContext context) {
    if(!hasImage) {
      return SizedBox(
        width: 92,
        height: 32,
        child: DecoPrimaryButton(
          label: '사진 추가',
          onPressed: onPickPhoto,
          height: 32,
          radius: 999,
          fontSize: 12,
          prefixIcon: const Icon(Icons.add_rounded),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 72,
          height: 34,
          child: DecoOutlinedButton(
            label: '삭제',
            onPressed: onDeletePhoto,
            height: 32,
            radius: 999,
            fontSize: 12,
            borderWidth: 1.2,
            variant: DecoOutlinedVariant.subtle,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 92,
          height: 32,
          child: DecoPrimaryButton(
            label: '사진 변경',
            onPressed: onPickPhoto,
            height: 32,
            radius: 999,
            fontSize: 12,
            prefixIcon: const Icon(Icons.refresh_rounded),
          ),
        ),
      ],
    );
  }
}
