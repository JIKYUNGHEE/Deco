import 'package:deco/ui/core/themes/deco_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/profile_character_section.dart';
import 'widgets/profile_intro_section.dart';
import 'widgets/profile_personal_info_section.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nicknameController = TextEditingController();
  final _birthController = TextEditingController();
  final _introController = TextEditingController();

  BearColor _bearColor = BearColor.pink;
  Gender _gender = Gender.female;

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
          _GradientTopBar(
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

    // TODO: 저장 로직 연결(서버/Firestore 등)
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
    // await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;
    context.go('/login');
  }
}

class _GradientTopBar extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final VoidCallback onBack;
  final VoidCallback onSave;

  const _GradientTopBar({
    required this.gradient,
    required this.title,
    required this.onBack,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 6, 12, 12),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.chevron_left, color: Colors.white),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              _SavePillButton(onTap: onSave),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavePillButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SavePillButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              blurRadius: 14,
              offset: Offset(0, 8),
              color: Color(0x1A000000),
            ),
          ],
        ),
        child: const Text(
          '저장',
          style: TextStyle(
            color: Color(0xFF7A3CFF),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
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
