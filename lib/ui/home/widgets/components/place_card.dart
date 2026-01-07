import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

///자주 가는 장소/추천 장소 같은 “장소 1개” 카드.
class PlaceCard extends StatelessWidget {
  final String title;
  final String category;
  final int count;

  final String? imageUrl;
  final String? assetImage;

  const PlaceCard({
    super.key,
    required this.title,
    required this.category,
    required this.count,
    this.imageUrl,
    this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(22);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: r,
        color: Colors.white.withValues(alpha: 0.70),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: r,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _PlaceImage(
                      imageUrl: imageUrl,
                      assetImage: assetImage,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    category,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.gray500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${count}회',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF7C3AED),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetImage;

  const _PlaceImage({this.imageUrl, this.assetImage});

  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;

    if (assetImage != null) {
      provider = AssetImage(assetImage!);
    } else if (imageUrl != null) {
      provider = NetworkImage(imageUrl!);
    }

    return Container(
      decoration: BoxDecoration(
        image: provider != null
            ? DecorationImage(image: provider, fit: BoxFit.cover)
            : null,
        gradient: provider == null
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.05),
                  Colors.black.withValues(alpha: 0.35),
                ],
              )
            : null,
      ),
    );
  }
}