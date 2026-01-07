import 'package:flutter/material.dart';

class DecoDateCard extends StatelessWidget {
  final double rating;
  final String dateText;
  final String title;
  final String routeText;
  final String? imageUrl;

  final List<Color> coverGradient;

  final VoidCallback? onTapThumbnail;

  const DecoDateCard({
    super.key,
    this.rating = 5.0,
    this.dateText = '2025.04.05',
    this.title = '주말 한강 피크닉',
    this.routeText = '선셋 → 치킨 → 야경',
    this.imageUrl,
    this.coverGradient = const [Color(0xFFEAEAEA), Color(0xFFBDBDBD)],
    this.onTapThumbnail,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(26);
    final t = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: r,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 32,
            offset: const Offset(0, 18),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 230,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _CoverImage(
                      imageUrl: imageUrl,
                      fallbackGradient: coverGradient,
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: IgnorePointer(
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.32),
                              Colors.white.withValues(alpha: 0.00),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 16,
                    top: 16,
                    child: _Pill(
                      background: const Color(0xFFFFC84A),
                      shadow: true,
                      child: Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              size: 18, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            rating.toStringAsFixed(1),
                            style: t.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: _Pill(
                      background: Colors.white.withValues(alpha: 0.92),
                      border: Colors.black.withValues(alpha: 0.06),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_rounded,
                              size: 16,
                              color: const Color(0xFFFF4FA3)
                                  .withValues(alpha: 0.95)),
                          const SizedBox(width: 8),
                          Text(
                            dateText,
                            style: t.labelLarge?.copyWith(
                              color: const Color(0xFF111827),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: t.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF111827),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.place_rounded,
                        size: 20,
                        color: const Color(0xFFFF4FA3)
                            .withValues(alpha: 0.90),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          routeText,
                          style: t.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF6B7280),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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

class _CoverImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final List<Color> fallbackGradient;

  const _CoverImage({
    this.imageUrl,
    this.assetPath,
    required this.fallbackGradient,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return _GradientFallback(fallbackGradient);
        },
        errorBuilder: (_, __, ___) =>
            _GradientFallback(fallbackGradient),
      );
    }

    return _GradientFallback(fallbackGradient);
  }
}

class _GradientFallback extends StatelessWidget {
  final List<Color> colors;

  const _GradientFallback(this.colors);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final Widget child;
  final Color background;
  final Color? border;
  final bool shadow;

  const _Pill({
    required this.child,
    required this.background,
    this.border,
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: border == null ? null : Border.all(color: border!, width: 1),
        boxShadow: shadow
            ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ]
            : null,
      ),
      child: DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.labelLarge,
        child: child,
      ),
    );
  }
}
