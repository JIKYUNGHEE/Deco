import 'package:deco/ui/core/themes/deco_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyPageSummarySection extends StatelessWidget {
  const MyPageSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: decoTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '마이페이지',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              const _MyPageWhiteCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyPageWhiteCard extends StatelessWidget {
  const _MyPageWhiteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 24,
            offset: Offset(0, 12),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _AvatarWithBadge(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '닉네임',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF1F1F1F),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '연결된 커플: ',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF7C7C7C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '기념일: 2024.04.01',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB0B0B0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFFC1DA), width: 1),
            ),
            child: Column(
              children: const [
                _NewsHeader(),
                SizedBox(height: 10),
                _NewsStatsRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarWithBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0EC),
            borderRadius: BorderRadius.circular(18),
          ),
          child: SvgPicture.asset(
            'assets/illustrations/pink-bear.svg',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          left: -3,
          top: -3,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFFFF4FA3),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _NewsHeader extends StatelessWidget {
  const _NewsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFFFF4FA3).withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.favorite,
            size: 12,
            color: Color(0xFFFF4FA3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '기록 뉴스',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1F1F1F),
          ),
        ),
      ],
    );
  }
}

class _NewsStatsRow extends StatelessWidget {
  const _NewsStatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StatItem(
            value: 'D+365',
            label: '함께한 날',
          ),
        ),
        _VerticalDivider(),
        Expanded(
          child: _StatItem(
            value: '24개',
            label: '데이트 코스',
          ),
        ),
        _VerticalDivider(),
        Expanded(
          child: _StatItem(
            value: '8곳',
            label: '이달의 데이트',
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: const Color(0xFFFF4FA3),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF7C7C7C),
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: const Color(0xFFFFC1DA),
    );
  }
}