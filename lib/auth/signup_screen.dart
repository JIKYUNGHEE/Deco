import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/core/themes/deco_theme_extension.dart';
import '../ui/core/widgets/deco_primary_button.dart';
import '../ui/core/widgets/deco_text_field.dart';
import 'bear_in_love_illustration.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nicknameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pw2Ctrl = TextEditingController();

  bool _obscurePw = true;
  bool _obscurePw2 = true;

  @override
  void dispose() {
    _nicknameCtrl.dispose();
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    _pw2Ctrl.dispose();
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
                  colors: [Color(0x00FFFFFF), Color(0xB3FFFFFF)],
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
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(constraints: BoxConstraints(minHeight: constraints.maxHeight - 40),child: Center(
                    child: _SignupCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                              const Spacer(),
                            ],
                          ),

                          const SizedBox(height: 6),

                          const BearInLoveIllustration(),
                          const SizedBox(height: 14),

                          Text(
                            '회원가입',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: decoTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '우리만의 데이트 코스를 남겨요',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: decoTheme.textSecondary,
                            ),
                          ),

                          const SizedBox(height: 18),

                          // _Label('닉네임'),
                          // const SizedBox(height: 8),
                          // DecoTextField(
                          //   controller: _nicknameCtrl,
                          //   hintText: '예) 한결커플닉네임',
                          // ),
                          //
                          // const SizedBox(height: 14),

                          // 이메일
                          _Label('이메일'),
                          const SizedBox(height: 8),
                          DecoTextField(
                            controller: _emailCtrl,
                            hintText: 'example@email.com',
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 14),

                          // 비밀번호
                          _Label('비밀번호'),
                          const SizedBox(height: 8),
                          DecoTextField(
                            controller: _pwCtrl,
                            hintText: '8자 이상',
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

                          const SizedBox(height: 14),

                          // 비밀번호 확인
                          _Label('비밀번호 확인'),
                          const SizedBox(height: 8),
                          DecoTextField(
                            controller: _pw2Ctrl,
                            hintText: '비밀번호를 한번 더 입력하세요',
                            obscureText: _obscurePw2,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _obscurePw2 = !_obscurePw2),
                              icon: Icon(
                                _obscurePw2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                                color: decoTheme.textSecondary,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            '가입을 누르면 이용약관 및 개인정보 처리방침에 동의하게 됩니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.35,
                              color: decoTheme.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 14),

                          // CTA
                          DecoPrimaryButton(label: '회원가입', onPressed: () {
                            context.go('/verify-email', extra: _emailCtrl.text.trim());
                          }),

                          const SizedBox(height: 18),

                          Text(
                            '이미 계정이 있으신가요?',
                            style: TextStyle(
                              fontSize: 13.5,
                              color: decoTheme.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),

                          GestureDetector(
                            onTap: () => context.go('/login'),
                            child: Text(
                              '로그인하러 가기',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                color: decoTheme.outlinePressed,
                                decoration: TextDecoration.underline,
                                decorationColor: decoTheme.outlinePressed,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                  ),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SignupCard extends StatelessWidget {
  final Widget child;

  const _SignupCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 380),
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
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
    final deco = Theme.of(context).extension<DecoThemeExtension>()!;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w800,
          color: deco.textPrimary,
        ),
      ),
    );
  }
}

class _CoupleIllustration extends StatelessWidget {
  const _CoupleIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _BlobFace(isPink: true),
          SizedBox(width: 10),
          Text('💕', style: TextStyle(fontSize: 22)),
          SizedBox(width: 10),
          _BlobFace(isPink: false),
        ],
      ),
    );
  }
}

class _BlobFace extends StatelessWidget {
  final bool isPink;
  const _BlobFace({required this.isPink});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPink
              ? const [Color(0xFFFF7ABF), Color(0xFFE85AAE)]
              : const [Color(0xFFB69CFF), Color(0xFF7A5CFF)],
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 14,
            offset: Offset(0, 10),
            color: Color(0x24000000),
          ),
        ],
      ),
      child: const Center(
        child: Text('•  •\n  ▢', textAlign: TextAlign.center),
      ),
    );
  }
}
