import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/themes/deco_theme_extension.dart';
import 'components/gradient_top_bar.dart';
import 'widgets/couple_anniversary_section.dart';
import 'widgets/couple_disconnect_section.dart';
import 'widgets/couple_nickname_section.dart';
import 'widgets/couple_summary_section.dart';

class CoupleEditScreen extends StatefulWidget {
  const CoupleEditScreen({super.key});

  @override
  State<CoupleEditScreen> createState() => _CoupleEditScreenState();
}

class _CoupleEditScreenState extends State<CoupleEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _coupleNameController = TextEditingController();
  final _anniversaryController = TextEditingController();
  final _myNicknameController = TextEditingController();
  final _partnerNicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    return Scaffold(
      body: Column(
        children: [
          GradientTopBar(
            gradient: decoTheme.primaryGradient,
            title: '커플 정보 편집',
            onBack: () => context.pop(),
            onSave: _onSave,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: const [
                    CoupleSummarySection(),
                    SizedBox(height: 14),
                    CoupleAnniversarySection(),
                    SizedBox(height: 14),
                    CoupleNicknameSection(),
                    SizedBox(height: 14),
                    CoupleDisconnectSection(),
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
}
