import 'package:deco/domain/models/course.dart';
import 'package:deco/domain/models/place.dart';
import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:deco/viewmodels/couple_summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/themes/deco_theme_extension.dart';
import '../../mypage/components/gradient_top_bar.dart';
import 'widgets/components/course_photo_carousel.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  final bool isShared;

  const CourseDetailScreen({
    super.key,
    required this.course,
    required this.isShared,
  });

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    final places = course.places ?? <Place>[];
    final imageUrls = _collectImageUrls(course);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5FB),
      body: Column(
        children: [
          GradientTopBar(
            gradient: decoTheme.primaryGradient,
            title: '코스 상세',
            onBack: () => context.pop(),
            onSave: () {},
            trailing: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('상세 메뉴는 다음 단계에서 연결해요.')),
                );
              },
              icon: const Icon(Icons.more_vert, color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              children: [
                CoursePhotoCarousel(imageUrls: imageUrls),

                const SizedBox(height: 18),

                if (isShared) ...[
                  _ImportCourseButton(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('내 코스로 가져오기 기능은 다음 단계에서 연결해요.'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _SharedCourseHeaderCard(course: course),
                ] else ...[
                  _MyCourseHeaderCard(course: course),
                  if ((course.daySentence ?? '').isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _QuoteCard(text: course.daySentence!),
                  ],
                  if ((course.memo ?? '').isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _MemoCard(memo: course.memo!),
                  ],
                ],

                const SizedBox(height: 16),

                if (isShared && (course.daySentence ?? '').isNotEmpty) ...[
                  _QuoteCard(text: course.daySentence!),
                  const SizedBox(height: 16),
                ],

                _PlaceListCard(places: places),

                const SizedBox(height: 18),

                _MapButton(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('지도 화면은 다음 단계에서 연결해요.')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _collectImageUrls(Course course) {
    final urls = <String>[];
    final cover = course.picture?.trim();

    if (cover != null && cover.isNotEmpty) {
      urls.add(cover);
    }

    for (final place in course.places ?? <Place>[]) {
      for (final picture in place.pictures ?? <String?>[]) {
        final url = picture?.trim();
        if (url != null && url.isNotEmpty) {
          urls.add(url);
        }
      }
    }

    return urls.toSet().toList();
  }
}

class _MyCourseHeaderCard extends StatelessWidget {
  final Course course;

  const _MyCourseHeaderCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Row(
        children: [
          Expanded(child: _CourseTitleAndDate(course: course)),
          const _CircleHeartButton(),
        ],
      ),
    );
  }
}

class _SharedCourseHeaderCard extends StatelessWidget {
  final Course course;

  const _SharedCourseHeaderCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final summary = context.watch<CoupleSummaryState>();

    return _BaseCard(
      borderColor: AppColors.primary.withValues(alpha: 0.45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CourseTitleAndDate(course: course),
          const SizedBox(height: 14),
          Divider(color: AppColors.primary.withValues(alpha: 0.18)),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: SvgPicture.asset(
                  'assets/images/pink-bear.svg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _coupleText(summary),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2F8),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.18),
                  ),
                ),
                child: Text(
                  '♡ ${course.favorites?.length ?? 0}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _coupleText(CoupleSummaryState summary) {
    final myName = summary.myNickName.trim().isEmpty
        ? '나'
        : summary.myNickName.trim();
    final coupleName = summary.coupleNickName.trim().isEmpty
        ? '상대방'
        : summary.coupleNickName.trim();

    return '$myName 💝 $coupleName';
  }
}

class _CourseTitleAndDate extends StatelessWidget {
  final Course course;

  const _CourseTitleAndDate({required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.title ?? '제목 없는 코스',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              size: 15,
              color: AppColors.subText,
            ),
            const SizedBox(width: 5),
            Text(
              _formatDate(course.date),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.subText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return '날짜 없음';
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}

class _ImportCourseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ImportCourseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.26),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: const Center(
            child: Text(
              '내 코스로 가져오기',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  final String text;

  const _QuoteCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return _TintCard(
      icon: Icons.chat_bubble_outline_rounded,
      title: '그날의 한 문장',
      child: Text(
        '“$text”',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          height: 1.5,
          color: AppColors.text,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MemoCard extends StatelessWidget {
  final String memo;

  const _MemoCard({required this.memo});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardSectionTitle(
            icon: Icons.remove_red_eye_outlined,
            title: '짧은 메모',
          ),
          const SizedBox(height: 12),
          Text(
            memo,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceListCard extends StatelessWidget {
  final List<Place> places;

  const _PlaceListCard({required this.places});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardSectionTitle(
            icon: Icons.location_on_outlined,
            title: '장소 (${places.length}곳)',
          ),
          const SizedBox(height: 14),
          if (places.isEmpty)
            const Text(
              '아직 추가된 장소가 없어요.',
              style: TextStyle(color: AppColors.subText),
            )
          else
            ...places.asMap().entries.map(
              (entry) => Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key == places.length - 1 ? 0 : 10,
                ),
                child: _PlaceItem(index: entry.key + 1, place: entry.value),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlaceItem extends StatelessWidget {
  final int index;
  final Place place;

  const _PlaceItem({required this.index, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: index.isOdd
                ? AppColors.primary
                : AppColors.secondary.withValues(alpha: 0.75),
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name ?? '이름 없는 장소',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                if ((place.address ?? '').isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    place.address!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.subText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MapButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: const Center(
            child: Text(
              '📍 이 날의 장소를 지도에서 보기',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TintCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _TintCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE8FA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
        boxShadow: _cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardSectionTitle(icon: icon, title: title),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _BaseCard extends StatelessWidget {
  final Widget child;
  final Color? borderColor;

  const _BaseCard({required this.child, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor ?? Colors.black.withValues(alpha: 0.04),
        ),
        boxShadow: _cardShadow,
      ),
      child: child,
    );
  }
}

class _CardSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _CardSectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: AppColors.primary.withValues(alpha: 0.92),
          child: Icon(icon, color: Colors.white, size: 15),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

class _CircleHeartButton extends StatelessWidget {
  const _CircleHeartButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 30),
    );
  }
}

final List<BoxShadow> _cardShadow = [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.08),
    blurRadius: 16,
    offset: const Offset(0, 8),
  ),
];
