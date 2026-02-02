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
  final _firebaseAuthService = FirebaseAuthService();

  final _formKey = GlobalKey<FormState>();

  final _nicknameController = TextEditingController();
  final _birthController = TextEditingController();
  final _introController = TextEditingController();

  BearColor _bearColor = BearColor.pink;
  Gender _gender = Gender.female;

  @override
  void initState() {
    super.initState();
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

  void _onSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    _formKey.currentState?.save();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    _userService.updateBearColor(uid, _bearColor);
    _userService.updateNickname(uid, _nicknameController.text.trim());
    _userService.updateBirth(uid, DateFormat('yyyy.MM.dd').parse(_birthController.text.trim()));
    _userService.updateGender(uid, _gender);
    _userService.updateIntroduce(uid, _introController.text.trim());

    context.read<CoupleSummaryState>().load();

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

    // ✅ FirebaseAuth 쓰면 아래 주석 해제
    _firebaseAuthService.deleteAccount();

    if (!context.mounted) return;
    context.go('/login');
  }
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
