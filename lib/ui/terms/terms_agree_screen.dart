import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/themes/deco_theme_extension.dart';
import '../core/widgets/deco_press_scale.dart';
import '../core/widgets/deco_primary_button.dart';
import 'notion_links.dart';

class TermsAgreeScreen extends StatefulWidget {
  const TermsAgreeScreen({super.key});

  @override
  State<TermsAgreeScreen> createState() => _TermsAgreeScreenState();
}

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

class _TermsAgreeScreenState extends State<TermsAgreeScreen> {
  bool agreeService = false;
  bool agreePrivacy = false;
  bool agreeMarketing = false;

  bool get agreeAll => agreeService && agreePrivacy && agreeMarketing;

  bool get canStart => agreeService && agreePrivacy;

  void toggleAll(bool v) {
    setState(() {
      agreeService = v;
      agreePrivacy = v;
      agreeMarketing = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: decoTheme.primaryGradient),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00FFFFFF), // 투명
                    Color(0xB3FFFFFF), // 아래로 갈수록 흰색
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  left: 8,
                  top: 8,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.chevron_left,
                      color: decoTheme.textPrimary,
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            '약관 동의',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: decoTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '데코를 시작하기 전에 약관에 동의해주세요',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: decoTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 18),

                          _AgreeBox(
                            child: Column(
                              children: [
                                _AgreeRow(
                                  checked: agreeAll,
                                  label: '전체 약관에 동의하세요',
                                  onChanged: toggleAll,
                                  bold: true,
                                ),
                                const SizedBox(height: 14),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: decoTheme.outlineColor,
                                ),
                                const SizedBox(height: 14),

                                _AgreeRow(
                                  checked: agreeService,
                                  label: '[필수] 서비스 이용약관 동의',
                                  onChanged: (v) {
                                    agreeService = v;
                                    setState(() {});
                                  },
                                  trailing: _ViewLink(
                                    onTap: () => openUrl(NotionLinks.serviceTerms),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                _AgreeRow(
                                  checked: agreePrivacy,
                                  label: '[필수] 개인정보 처리방침 동의',
                                  onChanged: (v) {
                                    agreePrivacy = v;
                                    setState(() {});
                                  },
                                  trailing: _ViewLink(
                                    onTap: () => openUrl(NotionLinks.privacyPolicy),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                _AgreeRow(
                                  checked: agreeMarketing,
                                  label: '[선택] 마케팅 정보 수신 동의',
                                  onChanged: (v) {
                                    agreeMarketing = v;
                                    setState(() {});
                                  },
                                  trailing: _ViewLink(
                                    onTap: () => openUrl(NotionLinks.serviceTerms),
                                  ),
                                  subText: '선택 항목에 동의하지 않아도 서비스 이용이 가능합니다',
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          // 하단 CTA
                          Opacity(
                            opacity: canStart ? 1.0 : 0.55,
                            child: IgnorePointer(
                              ignoring: !canStart,
                              child: DecoPrimaryButton(
                                label: '동의하고 데코 시작하기  ❤',
                                onPressed: () {
                                  // TODO: (필수 동의 저장) 후 다음 단계
                                  // 예: context.go('/signup'); 또는 홈/커플연결
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            blurRadius: 28,
            offset: Offset(0, 18),
            color: Color(0x1A000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _AgreeBox extends StatelessWidget {
  final Widget child;

  const _AgreeBox({required this.child});

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: decoTheme.textPrimary, width: 2),
      ),
      child: child,
    );
  }
}

class _AgreeRow extends StatelessWidget {
  final bool checked;
  final String label;
  final bool bold;
  final ValueChanged<bool> onChanged;
  final Widget? trailing;
  final String? subText;

  const _AgreeRow({
    required this.checked,
    required this.label,
    required this.onChanged,
    this.bold = false,
    this.trailing,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _DecoCheck(value: checked, onChanged: onChanged),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: bold ? 17 : 15,
                  fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
                  color: decoTheme.textPrimary,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        if (subText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: Text(
              subText!,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.35,
                color: decoTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _DecoCheck extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _DecoCheck({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final deco = Theme.of(context).extension<DecoThemeExtension>()!;

    return DecoPressScale(
      enabled: true,
      pressedScale: 1.05,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onChanged(!value),
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: value
                ? deco.outlinePressed.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: value ? deco.outlinePressed : deco.outlineColor,
              width: 1.4,
            ),
          ),
          child: value
              ? Icon(Icons.check, size: 16, color: deco.outlinePressed)
              : null,
        ),
      ),
    );
  }
}

class _ViewLink extends StatelessWidget {
  final VoidCallback onTap;

  const _ViewLink({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final deco = Theme.of(context).extension<DecoThemeExtension>()!;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        '보기',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: deco.textSecondary,
        ),
      ),
    );
  }
}
