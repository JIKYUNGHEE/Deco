import 'package:deco/config/app_state.dart';
import 'package:deco/ui/onboarding/widgets/onboarding_card.dart';
import 'package:deco/ui/onboarding/widgets/onboarding_dots.dart';
import 'package:deco/ui/onboarding/widgets/onboarding_mock_illustrations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/widgets/deco_outlined_button.dart';
import '../core/widgets/deco_primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == 2;

  void _goTo(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  void _next() => _goTo((_index + 1).clamp(0, 2));

  void _skip() => _goTo(2);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F0FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: OnboardingCard(
                  content: SizedBox(
                    height: 380,
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (i) => setState(() => _index = i),
                      children: [
                        _OnboardingPage1(),
                        _OnboardingPage2(),
                        _OnboardingPage3(),
                      ],
                    ),
                  ),
                  bottom: Column(
                    children: [
                      OnboardingDots(index: _index, onDotTap: (i) => _goTo(i)),
                      const SizedBox(height: 22),
                      _isLast
                          ? Column(
                              children: [
                                DecoPrimaryButton(
                                  label: '로그인',
                                  onPressed: () => {
                                    context.read<AppState>().setOnboardingDone(true),
                                    context.go('/login'),
                                  },
                                ),
                                const SizedBox(height: 12),
                                DecoOutlinedButton(
                                  label: '회원가입',
                                  onPressed: () => {
                                    context.read<AppState>().setOnboardingDone(true),
                                    context.go('/terms'),
                                  },
                                ),
                              ],
                            )
                          : DecoOutlinedButton(
                              label: '다음',
                              variant: DecoOutlinedVariant.subtle,
                              suffixIcon: const Icon(
                                Icons.chevron_right,
                                size: 20,
                              ),
                              onPressed: _next,
                            ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 20,
                top: 12,
                child: TextButton(
                  onPressed: _isLast ? null : _skip,
                  child: const Text('건너뛰기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage1 extends StatelessWidget {
  const _OnboardingPage1();

  @override
  Widget build(BuildContext context) {
    return OnboardingCard(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OnboardingIllust1(),
          const SizedBox(height: 22),
          const Text(
            '오늘 데이트 데코할래?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          const Text(
            '사진이랑 장소로\n우리 하루를 귀엽게 남겨요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage2 extends StatelessWidget {
  const _OnboardingPage2();

  @override
  Widget build(BuildContext context) {
    return OnboardingCard(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OnboardingIllust2(),
          const SizedBox(height: 18),
          const Text(
            '데이트를 코스로 남겨요',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          const Text(
            '카페, 산책, 식당...\n그날 다녀온 곳들을\n하나의 데코로 묶어요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage3 extends StatelessWidget {
  const _OnboardingPage3();

  @override
  Widget build(BuildContext context) {
    return OnboardingCard(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OnboardingIllust3(),
          const SizedBox(height: 18),
          const Text(
            '우리의 데이트, 오래도록',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          const Text(
            '캘린더로 보고\n지도도 보고\n언제든 다시 꺼내볼 수 있어요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
