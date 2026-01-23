import 'package:flutter/material.dart';

import '../../../../domain/models/course.dart';

class CourseCard extends StatelessWidget {
  final Course data;
  final VoidCallback? onTap;

  const CourseCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(22);
    final t = Theme.of(context).textTheme;
    final placesName = data.places
        ?.map((place) => place.name)
        .whereType<String>()
        .join(' → ')
        ?? '';

    int totalPicturesCount = 0;

    final places = data.places;
    if (places != null) {
      for (final place in places) {
        totalPicturesCount += place.pictures?.length ?? 0;
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: r,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.78),
            borderRadius: r,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (data.picture != null)
                        Positioned.fill(
                          child: Image.network(
                            data.picture!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (data.picture == null)
                        Container(
                          color: Colors.black.withValues(alpha: 0.10),
                          child: const Center(
                            child: Icon(Icons.image_outlined, size: 34),
                          ),
                        ),

                      IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.22),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 10,
                        top: 10,
                        child: _Pill(
                          icon: Icons.photo_library_outlined,
                          text: '$totalPicturesCount',
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: t.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Text(
                            '${data.date?.year}.${data.date?.month}.${data.date?.day}',
                            style: t.labelMedium?.copyWith(
                              color: Colors.black.withValues(alpha: 0.55),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              placesName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: t.labelMedium?.copyWith(
                                color: Colors.black.withValues(alpha: 0.65),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 16,
                            color: const Color(
                              0xFFFF4FA3,
                            ).withValues(alpha: 0.95),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${data.favorites?.length ?? 0}',
                            style: t.labelMedium?.copyWith(
                              color: Colors.black.withValues(alpha: 0.55),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.black.withValues(alpha: 0.35),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Pill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.black.withValues(alpha: 0.55)),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.black.withValues(alpha: 0.60),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCardData {
  final String title;
  final String dateText;
  final String routeText;
  final int likes;
  final int photos;

  const CourseCardData({
    required this.title,
    required this.dateText,
    required this.routeText,
    required this.likes,
    required this.photos,
  });
}
