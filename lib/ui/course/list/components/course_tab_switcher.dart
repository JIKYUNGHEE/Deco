import 'package:flutter/material.dart';

enum CourseTab { my, public }

class CourseTabSwitcher extends StatelessWidget {
  final CourseTab current;
  final ValueChanged<CourseTab> onChanged;

  const CourseTabSwitcher({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(16);

    Widget tabButton(String text, CourseTab tab) {
      final selected = current == tab;

      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onChanged(tab),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: r,
              color: selected
                  ? const Color(0xFF7C3AED).withValues(alpha: 0.16)
                  : Colors.transparent,
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: selected
                    ? const Color(0xFF7C3AED)
                    : Colors.black.withValues(alpha: 0.55),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          tabButton('우리 코스', CourseTab.my),
          const SizedBox(width: 6),
          tabButton('공개 코스', CourseTab.public),
        ],
      ),
    );
  }
}
