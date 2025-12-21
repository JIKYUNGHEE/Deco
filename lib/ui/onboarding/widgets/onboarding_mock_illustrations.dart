import 'package:flutter/material.dart';

class _IllustBox extends StatelessWidget {
  final Widget child;
  const _IllustBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: child),
    );
  }
}

class OnboardingIllust1 extends StatelessWidget {
  const OnboardingIllust1({super.key});

  @override
  Widget build(BuildContext context) {
    return const _IllustBox(
      child: CircleAvatar(
        radius: 38,
        backgroundColor: Color(0xFFE85AAE),
        child: Icon(Icons.favorite, color: Colors.white, size: 30),
      ),
    );
  }
}

class OnboardingIllust2 extends StatelessWidget {
  const OnboardingIllust2({super.key});

  @override
  Widget build(BuildContext context) {
    return const _IllustBox(
      child: Icon(Icons.view_list_rounded, size: 56),
    );
  }
}

class OnboardingIllust3 extends StatelessWidget {
  const OnboardingIllust3({super.key});

  @override
  Widget build(BuildContext context) {
    return const _IllustBox(
      child: Icon(Icons.map_outlined, size: 56),
    );
  }
}
