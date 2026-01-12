import 'package:deco/data/services/firebase_auth_service.dart';
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
  final _auth = FirebaseAuthService();

  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  bool _obscurePw = true;

  String? _emailError;
  String? _pwError;

  bool get _canSubmit =>
      _emailError == null &&
          _pwError == null &&
          _emailCtrl.text
              .trim()
              .isNotEmpty &&
          _pwCtrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _emailCtrl.addListener(() {
      if (_emailError != null) _validateEmail(silent: true);
    });

    _pwCtrl.addListener(() {
      if (_pwError != null) {
        _validatePassword(silent: true);
      }
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwCtrl.dispose();
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


  bool _validateAll() {
    final ok1 = _validateEmail();
    final ok2 = _validatePassword();
    return ok1 && ok2;
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();

    if (!_validateAll()) return;

    String email = _emailCtrl.text.trim();
    String password = _pwCtrl.text.trim();
    _auth
        .signInWithEmail(email: email, password: password)
        .then((_) {
      if (mounted) {
        context.go('/connect');
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
                final bottomInset = MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom;

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
                              errorText: _emailError,
                            ),

                            const SizedBox(height: 14),

                            const _Label('비밀번호'),
                            const SizedBox(height: 8),
                            DecoTextField(
                              controller: _pwCtrl,
                              hintText: '••••••••',
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

                            const SizedBox(height: 16),

                            DecoPrimaryButton(
                              label: '로그인',
                              onPressed:_canSubmit ? _onSubmit : null,
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
