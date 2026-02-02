import 'package:deco/data/services/couple_service.dart';
import 'package:deco/data/services/firebase_auth_service.dart';
import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:deco/ui/core/widgets/deco_card.dart';
import 'package:deco/viewmodels/couple_summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/models/couple.dart';
import '../core/themes/deco_theme_extension.dart';

class CompleteCoupleScreen extends StatefulWidget {
  CompleteCoupleScreen({super.key});

  @override
  State<CompleteCoupleScreen> createState() => _CompleteCoupleScreenState();
}

class _CompleteCoupleScreenState extends State<CompleteCoupleScreen> {
  final _auth = FirebaseAuthService();

  final _coupleService = CoupleService();
  final _firstNameCtrl = TextEditingController();
  final _secondNameCtrl = TextEditingController();
  final _anniversaryDateCtrl = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(1990, 1, 1);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate == null) return;

    setState(() {
      _selectedDate = pickedDate;
      _anniversaryDateCtrl.text = DateFormat('yyyy.MM.dd').format(pickedDate);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameCtrl.dispose();
    _secondNameCtrl.dispose();
    _anniversaryDateCtrl.dispose();
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
                  colors: [Color(0x00FFFFFF), Color(0xB3FFFFFF)],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  ],
                ),

                _CoupleIllustCard(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/glitter.png', fit: BoxFit.cover),
                    Text(
                      '연결 완료!',
                      style: TextStyle(
                        color: AppColors.surface,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Image.asset('assets/images/glitter.png', fit: BoxFit.cover),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  '축하해요!🎉',
                  style: TextStyle(color: AppColors.surface, fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  '이제 함께 데이트 추억을\n 기록할 수 있어요',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.surface, fontSize: 14),
                ),
                SizedBox(height: 16),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      DecoCard(
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Text(
                              '우리의 이름을 설정해주세요',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '💕나',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: decoTheme.textSecondary,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFfdf2f8),
                                          Color(0xFFFCE7F3),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: TextField(
                                      controller: _firstNameCtrl,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Image.asset('assets/images/heart.png'),
                                  SizedBox(height: 4),
                                  Text(
                                    '💜 짝꿍',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: decoTheme.textSecondary,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFAF5FF),
                                          Color(0xFFF3E8FF),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: TextField(
                                      controller: _secondNameCtrl,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '💑 사귄 날짜',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: decoTheme.textSecondary,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFDF2F8),
                                          Color(0xFFFAF5FF),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: TextField(
                                      controller: _anniversaryDateCtrl,
                                      onTap: _presentDatePicker,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        hintText: '날짜를 선택해 주세요',
                                        suffixIcon: const Icon(
                                          Icons.calendar_month,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 14,
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            Couple? couple = await _coupleService
                                .readMyCoupleByInvitee();
                            if (couple != null) {
                              final updated = couple.copyWith(
                                anniversaryDate: _selectedDate,
                              );
                              await _coupleService.updateMyCouple(updated);
                              await _auth.updateCoupleNickname(
                                couple,
                                _firstNameCtrl.text,
                                _secondNameCtrl.text,
                              );
                              context.read<CoupleSummaryState>().load();
                              context.go('/home');
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.surface),
                            minimumSize: Size.fromHeight(60),
                          ),
                          child: Text(
                            '시작하기✨',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        '나중에 설정하기',
                        style: TextStyle(
                          color: AppColors.surface,
                          fontSize: 14,
                        ),
                      ),
                    ],
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

class _CoupleIllustCard extends StatefulWidget {
  const _CoupleIllustCard();

  @override
  State<StatefulWidget> createState() => _CoupleIllustCardState();
}

class _CoupleIllustCardState extends State<_CoupleIllustCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/illustrations/pink-bear.svg',
                width: 132,
              ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                'assets/illustrations/purple-bear.svg',
                width: 132,
              ),
            ],
          ),

          Positioned(
            child: ScaleTransition(
              scale: Tween(
                begin: 0.85,
                end: 1.1,
              ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller),
              child: Text('🎉', style: TextStyle(fontSize: 42)),
            ),
          ),
        ],
      ),
    );
  }
}
