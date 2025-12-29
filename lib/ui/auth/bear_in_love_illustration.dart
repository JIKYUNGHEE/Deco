import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/themes/app_colors.dart';


class BearInLoveIllustration extends StatefulWidget {
  const BearInLoveIllustration({super.key});

  @override
  State<BearInLoveIllustration> createState() => _BearInLoveIllustrationState();
}

class _BearInLoveIllustrationState extends State<BearInLoveIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/illustrations/pink-bear.svg',
                width: 72,
              ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                'assets/illustrations/purple-bear.svg',
                width: 72,
              ),
            ],
          ),

          Positioned(
            top: 20,
            child: ScaleTransition(
              scale: Tween(begin: 0.85, end: 1.1)
                  .chain(CurveTween(curve: Curves.easeInOut))
                  .animate(_controller),
              child: Icon(
                Icons.favorite,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
