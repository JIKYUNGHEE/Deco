import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/themes/deco_theme_extension.dart';
import '../core/widgets/deco_primary_button.dart';
import '../core/widgets/deco_outlined_button.dart';

class CoupleConnectScreen extends StatelessWidget {
  const CoupleConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.chevron_left,
                        color: decoTheme.textPrimary,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 72),
                      const _CoupleIllustCard(),
                      const SizedBox(height: 22),

                      Text(
                        '커플을 연결할까요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: decoTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        '둘 중 한 사람만 방을 만들고\n다른 한 사람은 초대 코드를 입력해주세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          color: decoTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    DecoPrimaryButton(
                      radius: 60,
                      label: '커플 방 만들기',
                      prefixIcon: const Icon(Icons.link),
                      onPressed: () {
                        context.go('/create-room');
                      },
                    ),
                    const SizedBox(height: 12),
                    DecoOutlinedButton(
                      radius: 60,
                      label: '초대 코드 입력하기',
                      onPressed: () {
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '둘 중 한 명만 방을 만들면 돼요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: decoTheme.textSecondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CoupleIllustCard extends StatelessWidget {
  const _CoupleIllustCard();

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 360),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: decoTheme.outlinePressed.withOpacity(0.55),
          width: 1.4,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 28,
            offset: Offset(0, 18),
            color: Color(0x1F000000),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/illustrations/pink-bear.svg', width: 92),
              Column(
                children: [
                  const SizedBox(height: 22),
                  Icon(
                    Icons.favorite,
                    color: decoTheme.outlinePressed,
                    size: 18,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 42,
                    height: 2,
                    decoration: BoxDecoration(
                      color: decoTheme.outlinePressed.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/illustrations/purple-bear.svg',
                width: 92,
              ),
            ],
          ),

          Positioned(
            left: -6,
            top: -6,
            child: Icon(
              Icons.favorite,
              size: 16,
              color: decoTheme.outlinePressed.withOpacity(0.75),
            ),
          ),
          Positioned(
            right: -6,
            top: -6,
            child: Icon(
              Icons.favorite,
              size: 16,
              color: decoTheme.outlinePressed.withOpacity(0.75),
            ),
          ),

          Positioned(
            bottom: -10,
            child: Text(
              '✨',
              style: TextStyle(fontSize: 16, color: decoTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
