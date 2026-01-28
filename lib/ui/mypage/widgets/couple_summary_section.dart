import 'package:deco/ui/core/widgets/deco_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoupleSummarySection extends StatelessWidget {
  const CoupleSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _BearAvatar('assets/illustrations/pink-bear.svg', '나'),
              Column(
                children: const [
                  Icon(Icons.favorite, color: Color(0xFFFF4FA3)),
                  SizedBox(height: 4),
                  Text('D+621',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF4FA3))),
                ],
              ),
              _BearAvatar('assets/illustrations/purple-bear.svg', '상대방'),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0F6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              '💘 함께한 지 621일째 되는 날이에요!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFFFF4FA3),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BearAvatar extends StatelessWidget {
  final String asset;
  final String label;

  const _BearAvatar(this.asset, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0EC),
            borderRadius: BorderRadius.circular(24),
          ),
          child: SvgPicture.asset(asset),
        ),
        const SizedBox(height: 6),
        Text(label,
            style:
            const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
      ],
    );
  }
}