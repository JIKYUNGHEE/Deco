import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class DecoNavItem {
  final String label;
  final String emoji;

  const DecoNavItem({
    required this.label,
    required this.emoji,
  });
}

class DecoBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  final bool bearIsPink;

  const DecoBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.bearIsPink,
  });

  static const _items = <DecoNavItem>[
    DecoNavItem(label: '홈', emoji: '🏠'),
    DecoNavItem(label: '코스', emoji: '📍'),
    DecoNavItem(label: '캘린더', emoji: '📅'),
    DecoNavItem(label: '마이', emoji: '👥'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Container(
          height: 74,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Row(
            children: List.generate(_items.length, (i) {
              final selected = currentIndex == i;
              final item = _items[i];

              return Expanded(
                child: _DecoNavItem(
                  label: item.label,
                  emoji: item.emoji,
                  selected: selected,
                  bearIsPink: bearIsPink,
                  onTap: () => onTap(i),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}



class _DecoNavItem extends StatelessWidget {
  final bool selected;
  final String label;
  final String emoji;
  final bool bearIsPink; // 선택된 탭의 곰 색 토글용
  final VoidCallback onTap;

  const _DecoNavItem({
    super.key,
    required this.selected,
    required this.label,
    required this.emoji,
    required this.bearIsPink,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelColor =
    selected ? const Color(0xFFFF4FA3) : const Color(0xFF9CA3AF);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: selected
                      ? _BearNavTile(isPink: bearIsPink)
                      : _EmojiNavTile(emoji: emoji),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  height: 1.0,
                  fontWeight: FontWeight.w800,
                  color: labelColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmojiNavTile extends StatelessWidget {
  final String emoji;
  const _EmojiNavTile({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        emoji,
        style: const TextStyle(
          fontSize: 18,
          height: 1.0,
        ),
      ),
    );
  }
}

class _BearNavTile extends StatelessWidget {
  final bool isPink;
  final double boxSize;
  final double bearSize;

  const _BearNavTile({
    super.key,
    required this.isPink,
    this.boxSize = 44,
    this.bearSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isPink ? AppColors.primary : AppColors.secondary;
    final assetPath =
    isPink ? 'assets/illustrations/pink-bear.svg' : 'assets/illustrations/purple-bear.svg';

    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.14),
                  blurRadius: 16,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),

          Positioned(
            top: -8,
            child: SvgPicture.asset(
              assetPath,
              width: bearSize,
              height: bearSize,
            ),
          ),
        ],
      ),
    );
  }
}