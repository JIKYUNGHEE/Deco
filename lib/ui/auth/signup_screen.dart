import 'package:deco/data/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/themes/deco_theme_extension.dart';
import '../core/widgets/deco_card.dart';
import '../core/widgets/deco_primary_button.dart';
import '../core/widgets/deco_text_field.dart';
import 'bear_in_love_illustration.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuthService();

  final _nicknameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pw2Ctrl = TextEditingController();

  bool _obscurePw = true;
  bool _obscurePw2 = true;

  String? _emailError;
  String? _pwError;
  String? _pw2Error;

  bool get _canSubmit =>
      _emailError == null &&
      _pwError == null &&
      _pw2Error == null &&
      _emailCtrl.text.trim().isNotEmpty &&
      _pwCtrl.text.isNotEmpty &&
      _pw2Ctrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _emailCtrl.addListener(() {
      if (_emailError != null) _validateEmail(silent: true);
    });

    _pwCtrl.addListener(() {
      if (_pwError != null || _pw2Error != null) {
        _validatePassword(silent: true);
        _validatePassword2(silent: true);
      }
      if (mounted) setState(() {});
    });

    _pw2Ctrl.addListener(() {
      if (_pw2Error != null) _validatePassword2(silent: true);
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _nicknameCtrl.dispose();
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    _pw2Ctrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final reg = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return reg.hasMatch(email);
  }

  bool _validateEmail({bool silent = false}) {
    final email = _emailCtrl.text.trim();
    String? err;

    if (email.isEmpty) {
      err = null;
    } else if (!_isValidEmail(email)) {
      err = '이메일 형식이 올바르지 않아요.';
    }

    if (!silent || err != _emailError) {
      setState(() => _emailError = err);
    }
    return err == null;
  }

  bool _validatePassword({bool silent = false}) {
    final pw = _pwCtrl.text;
    String? err;

    if (pw.isEmpty) {
      err = silent ? _pwError : '비밀번호를 입력해주세요.';
    } else if (pw.length < 8) {
      err = '비밀번호는 8자 이상이어야 해요.';
    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$').hasMatch(pw)) {
      err = '영문과 숫자를 함께 포함해주세요.';
    }

    if (!silent || err != _pwError) {
      setState(() => _pwError = err);
    }
    return err == null;
  }

  bool _validatePassword2({bool silent = false}) {
    final pw = _pwCtrl.text;
    final pw2 = _pw2Ctrl.text;
    String? err;

    if (pw2.isEmpty) {
      err = silent ? _pw2Error : '비밀번호를 한 번 더 입력해주세요.';
    } else if (pw2 != pw) {
      err = '비밀번호가 일치하지 않아요.';
    }

    if (!silent || err != _pw2Error) {
      setState(() => _pw2Error = err);
    }
    return err == null;
  }

  bool _validateAll() {
    final ok1 = _validateEmail();
    final ok2 = _validatePassword();
    final ok3 = _validatePassword2();
    return ok1 && ok2 && ok3;
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();

    if (!_validateAll()) return;

    String nickname = _nicknameCtrl.text.trim();
    String email = _emailCtrl.text.trim();
    String password = _pwCtrl.text.trim();
    _auth
        .signUpWithEmail(nickname: nickname, email: email, password: password)
        .then((_) {
          if (mounted) {
            context.go('/verify-email', extra: _emailCtrl.text.trim());
          }
        })
        .catchError((error) {
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.toString())));
          }
        });
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
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 40,
                    ),
                    child: Center(
                      child: DecoCard(
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

                            _Label('닉네임'),
                            const SizedBox(height: 8),
                            DecoTextField(
                              controller: _nicknameCtrl,
                            ),

                            const SizedBox(height: 14),

                            // 이메일
                            _Label('이메일'),
                            const SizedBox(height: 8),
                            DecoTextField(
                              controller: _emailCtrl,
                              hintText: 'example@email.com',
                              keyboardType: TextInputType.emailAddress,
                              errorText: _emailError,
                            ),

                            const SizedBox(height: 14),

                            // 비밀번호
                            _Label('비밀번호'),
                            const SizedBox(height: 8),
                            DecoTextField(
                              controller: _pwCtrl,
                              hintText: '8자 이상',
                              obscureText: _obscurePw,
                              errorText: _pwError,
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
                              errorText: _pw2Error,
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
                            DecoPrimaryButton(
                              label: '회원가입',
                              onPressed: _canSubmit ? _onSubmit : null,
                            ),

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
