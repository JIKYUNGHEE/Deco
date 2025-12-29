import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../auth/bear_in_love_illustration.dart';
import '../core/themes/deco_theme_extension.dart';
import '../core/widgets/deco_primary_button.dart';
import '../core/widgets/deco_outlined_button.dart';
import '../core/widgets/deco_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  bool _obscurePw = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    Color(0x00FFFFFF),
                    Color(0xB3FFFFFF),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bottomInset = MediaQuery.of(context).viewInsets.bottom;

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints:
                    BoxConstraints(minHeight: constraints.maxHeight - 40),
                    child: Center(
                      child: _LoginCard(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 8),

                            const BearInLoveIllustration(),
                            const SizedBox(height: 10),

                            Text(
                              '로그인',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: decoTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '우리 데이트 기록',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: decoTheme.textSecondary,
                              ),
                            ),

                            const SizedBox(height: 18),

                            const _Label('이메일'),
                            const SizedBox(height: 8),
                            DecoTextField(
                              controller: _emailCtrl,
                              hintText: 'example@email.com',
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 14),

                            const _Label('비밀번호'),
                            const SizedBox(height: 8),
                            DecoTextField(
                              controller: _pwCtrl,
                              hintText: '••••••••',
                              obscureText: _obscurePw,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    setState(() => _obscurePw = !_obscurePw),
                                icon: Icon(
                                  _obscurePw
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 20,
                                  color: decoTheme.textSecondary,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            DecoPrimaryButton(
                              label: '로그인',
                              onPressed: () {
                                context.go('/connect');
                              },
                            ),

                            const SizedBox(height: 18),

                            _DividerOr(textColor: decoTheme.textSecondary),

                            const SizedBox(height: 16),

                            DecoOutlinedButton(
                              label: '회원가입',
                              variant: DecoOutlinedVariant.normal,
                              onPressed: () => context.go('/signup'),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  final Widget child;
  const _LoginCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 380),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
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

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w800,
          color: decoTheme.textPrimary,
        ),
      ),
    );
  }
}

class _DividerOr extends StatelessWidget {
  final Color textColor;
  const _DividerOr({required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(thickness: 1, color: Color(0xFFE5E7EB)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '또는',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
        const Expanded(
          child: Divider(thickness: 1, color: Color(0xFFE5E7EB)),
        ),
      ],
    );
  }
}
