import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/themes/deco_theme_extension.dart';
import '../core/widgets/deco_card.dart';
import '../core/widgets/deco_primary_button.dart';


class EmailVerifyScreen extends StatelessWidget {
  final String email; // 회원가입에서 전달

  const EmailVerifyScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final deco = Theme.of(context).extension<DecoThemeExtension>()!;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(decoration: BoxDecoration(gradient: deco.primaryGradient)),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00FFFFFF),
                    Color(0xB3FFFFFF),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DecoCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // back
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => context.pop(),
                            icon: Icon(Icons.chevron_left, color: deco.textPrimary),
                          ),
                          const Spacer(),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // icon circle (메일 아이콘)
                      _IconCircle(
                        child: const Icon(Icons.mail_outline, size: 30, color: Colors.white),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        '이메일 인증',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: deco.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        '입력하신 이메일로 인증 링크를 보냈어요',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: deco.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: deco.outlinePressed, // 핑크 강조
                        ),
                      ),

                      const SizedBox(height: 18),

                      // steps box
                      _StepsBox(
                        child: Column(
                          children: const [
                            _StepRow(
                              number: 1,
                              text: '이메일함에서 ',
                              highlight: 'deco',
                              text2: '에서 보낸 메일\n을 확인하세요',
                            ),
                            SizedBox(height: 16),
                            _StepRow(
                              number: 2,
                              text: '메일 내 ',
                              highlight: '"인증 링크"',
                              text2: '를 클릭하세요',
                            ),
                            SizedBox(height: 16),
                            _StepRow(
                              number: 3,
                              text: '아래 버튼을 눌러 인증 완료를 확인\n하세요',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      DecoPrimaryButton(
                        label: '이메일 인증 확인',
                        prefixIcon: const Icon(Icons.check_circle_outline, color: Colors.white),
                        onPressed: () {
                          context.go('/login');
                        },
                      ),

                      const SizedBox(height: 14),

                      Text(
                        '이메일이 오지 않았다면 스팸 메일함을 확인해주세요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: deco.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  final Widget child;
  const _IconCircle({required this.child});

  @override
  Widget build(BuildContext context) {
    final deco = Theme.of(context).extension<DecoThemeExtension>()!;
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: deco.primaryGradient,
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 12),
            color: Color(0x26000000),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class _StepsBox extends StatelessWidget {
  final Widget child;
  const _StepsBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F1F8), // 연한 보라 회색(톤 맞춤)
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}

class _StepRow extends StatelessWidget {
  final int number;
  final String text;
  final String? highlight;
  final String? text2;

  const _StepRow({
    required this.number,
    required this.text,
    this.highlight,
    this.text2,
  });

  @override
  Widget build(BuildContext context) {
    final deco = Theme.of(context).extension<DecoThemeExtension>()!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepBadge(number: number),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 15,
                height: 1.35,
                fontWeight: FontWeight.w700,
                color: deco.textPrimary,
              ),
              children: [
                TextSpan(text: text),
                if (highlight != null)
                  TextSpan(
                    text: highlight,
                    style: TextStyle(color: deco.outlinePressed),
                  ),
                if (text2 != null) TextSpan(text: text2),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StepBadge extends StatelessWidget {
  final int number;
  const _StepBadge({required this.number});

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: decoTheme.outlinePressed.withOpacity(0.9), // 핑크 계열
        boxShadow: const [
          BoxShadow(
            blurRadius: 14,
            offset: Offset(0, 10),
            color: Color(0x1F000000),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
