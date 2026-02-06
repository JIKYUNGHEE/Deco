import 'package:deco/data/services/account_service.dart';
import 'package:deco/data/services/couple_service.dart';
import 'package:deco/data/services/firebase_auth_service.dart';
import 'package:deco/data/services/user_service.dart';
import 'package:deco/ui/core/themes/deco_theme_extension.dart';
import 'package:deco/viewmodels/couple_summary_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'components/gradient_top_bar.dart';
import 'view_models/user_summary_state.dart';
import 'widgets/profile_character_section.dart';
import 'widgets/profile_intro_section.dart';
import 'widgets/profile_personal_info_section.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _userService = UserService();
  final _authService = FirebaseAuthService();
  final _coupleService = CoupleService();
  late final _accountService;

  final _formKey = GlobalKey<FormState>();

  final _nicknameController = TextEditingController();
  final _birthController = TextEditingController();
  final _introController = TextEditingController();

  BearColor _bearColor = BearColor.pink;
  Gender _gender = Gender.female;

  @override
  void initState() {
    super.initState();
    _accountService = AccountService(
      _authService,
      _coupleService,
      _userService,
    );

    Future.microtask(() async {
      final state = context.read<UserSummaryState>();
      await state.load();
      _nicknameController.text = state.nickName ?? '';

      final birth = state.birth == null
          ? ''
          : DateFormat('yyyy.MM.dd').format(state.birth!);
      _birthController.text = birth;
      _introController.text = state.introduce ?? '';

      final gender = state.gender ?? "male";
      setState(() {
        _gender = (gender == "male") ? Gender.male : Gender.female;
        _bearColor = state.bearColor ?? BearColor.pink;
      });
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _birthController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    return Scaffold(
      body: Column(
        children: [
          GradientTopBar(
            gradient: decoTheme.primaryGradient,
            title: '프로필 편집',
            onBack: () => context.pop(),
            onSave: _onSave,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ProfileCharacterSection(
                      selected: _bearColor,
                      onSelect: (c) => setState(() => _bearColor = c),
                    ),
                    const SizedBox(height: 14),

                    ProfilePersonalInfoSection(
                      nicknameController: _nicknameController,
                      birthController: _birthController,
                      gender: _gender,
                      onGenderChanged: (g) => setState(() => _gender = g),
                    ),
                    const SizedBox(height: 14),

                    ProfileIntroSection(introController: _introController),
                    const SizedBox(height: 14),

                    TextButton(
                      onPressed: () => _confirmDeleteAccount(context),
                      child: const Text(
                        '회원 탈퇴',
                        style: TextStyle(
                          color: Color(0xFFE5484D),
                          fontWeight: FontWeight.w800,
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
    );
  }

  void _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    _formKey.currentState?.save();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await _userService.updateBearColor(uid, _bearColor);
    await _userService.updateNickname(uid, _nicknameController.text.trim());
    await _userService.updateBirth(
      uid,
      DateFormat('yyyy.MM.dd').parse(_birthController.text.trim()),
    );
    await _userService.updateGender(uid, _gender);
    await _userService.updateIntroduce(uid, _introController.text.trim());

    await context.read<CoupleSummaryState>().load();

    context.pop();
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('정말 탈퇴 하시겠어요?'),
        content: const Text('다시 가입해야 이용할 수 있어요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('회원 탈퇴'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    try {
      await _accountService.deleteAccount();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        final password = await _askPassword(context);
        if (password == null || password.isEmpty) return;

        try {
          await _authService.reauthenticateWithPassword(password);
          await _accountService.deleteAccount();
        } on FirebaseAuthException catch (e) {
          if (!context.mounted) return;

          final msg = (e.code == 'wrong-password')
              ? '비밀번호가 올바르지 않아요.'
              : '재인증에 실패했어요. (${e.code})';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
          return;
        }
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('탈퇴에 실패했어요. (${e.code})')),
        );
        return;
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('탈퇴 중 오류가 발생했어요.')),
      );
      return;
    }

    if (!context.mounted) return;
    context.go('/login');
  }
}

Future<String?> _askPassword(BuildContext context) async {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: const Text('비밀번호 확인'),
      content: TextField(
        controller: controller,
        obscureText: true,
        decoration: const InputDecoration(hintText: '현재 비밀번호를 입력하세요'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(null),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
          child: const Text('확인'),
        ),
      ],
    ),
  );
}

enum BearColor { pink, purple, blue, green }

extension BearColorX on BearColor {
  String get label {
    switch (this) {
      case BearColor.pink:
        return '핑크';
      case BearColor.purple:
        return '퍼플';
      case BearColor.blue:
        return '블루';
      case BearColor.green:
        return '그린';
    }
  }

  Color get swatch {
    switch (this) {
      case BearColor.pink:
        return const Color(0xFFFF4FA3);
      case BearColor.purple:
        return const Color(0xFF8B5CFF);
      case BearColor.blue:
        return const Color(0xFF2F7BFF);
      case BearColor.green:
        return const Color(0xFF2ECC71);
    }
  }

  String get assetPath {
    switch (this) {
      case BearColor.pink:
        return 'assets/illustrations/pink-bear.svg';
      case BearColor.purple:
        return 'assets/illustrations/purple-bear.svg';
      case BearColor.blue:
        return 'assets/illustrations/blue-bear.svg';
      case BearColor.green:
        return 'assets/illustrations/green-bear.svg';
    }
  }
}

enum Gender { male, female }

InputDecoration inputDecoration({required String hint}) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFE9E9EE)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFE9E9EE)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFFF4FA3), width: 1.3),
    ),
  );
}
