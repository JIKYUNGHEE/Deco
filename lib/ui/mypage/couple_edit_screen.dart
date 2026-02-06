import 'package:deco/data/services/couple_service.dart';
import 'package:deco/data/services/user_service.dart';
import 'package:deco/viewmodels/couple_summary_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/models/couple.dart';
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
  final _userService = UserService();
  final _coupleService = CoupleService();

  final _formKey = GlobalKey<FormState>();

  final _anniversaryController = TextEditingController();
  final _myNicknameController = TextEditingController();
  final _coupleNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _anniversaryController.dispose();
    _myNicknameController.dispose();
    _coupleNameController.dispose();
  }

  @override
  void initState() {
    super.initState();

    final state = context.read<CoupleSummaryState>();
    _anniversaryController.text = state.anniversaryDate;
    _myNicknameController.text = state.myNickName;
    _coupleNameController.text = state.coupleNickName;
  }

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    final summary = context.watch<CoupleSummaryState>();

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
                  children: [
                    CoupleSummarySection(daysTogether: summary.daysTogether),
                    SizedBox(height: 14),
                    CoupleAnniversarySection(anniversaryController: _anniversaryController,),
                    SizedBox(height: 14),
                    CoupleNicknameSection(myNickNameController: _myNicknameController, coupleNickNameController: _coupleNameController,),
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

  void _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    String uid = FirebaseAuth.instance.currentUser!.uid;
    String? coupleId = await _coupleService.findMyCoupleId(uid);
    if(coupleId == null) return;

    Couple? couple = await _coupleService.readCouple(coupleId);
    if(couple == null) return;
    String? coupleUid = couple.invitor == uid ? couple.invitee : couple.invitor;
    if(coupleUid == null) return;

    await _userService.updateNickname(uid, _myNicknameController.text.trim());
    await _userService.updateNickname(coupleUid, _coupleNameController.text.trim());
    await _coupleService.updateCoupleAnniversaryDate(coupleId, DateFormat('yyyy.MM.dd').parse(_anniversaryController.text.trim()));

    await context.read<CoupleSummaryState>().load();
    context.pop();
  }
}
