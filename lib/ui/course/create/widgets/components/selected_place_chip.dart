import 'package:flutter/material.dart';

class SelectedPlaceChip extends StatelessWidget {
  final int index;
  final String title;
  final String tag;
  final String location;
  final VoidCallback? onRemove;

  const SelectedPlaceChip({
    super.key,
    required this.index,
    required this.title,
    required this.tag,
    required this.location,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(18);

    final border = const Color(0xFFFF4FA3).withValues(alpha: 0.35);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(
        borderRadius: r,
        color: Colors.white,
        border: Border.all(color: border, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFF4FA3).withValues(alpha: 0.16),
            ),
            child: Text(
              '$index',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: const Color(0xFFFF4FA3),
                height: 1.0,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.black.withValues(alpha: 0.80),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      tag,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFFF4FA3),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.black.withValues(alpha: 0.40),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.close_rounded,
                size: 18,
                color: const Color(0xFFFF4FA3).withValues(alpha: 0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}