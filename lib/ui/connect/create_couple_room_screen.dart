import 'package:deco/data/services/couple_service.dart';
import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:deco/ui/core/widgets/deco_outlined_button.dart';
import 'package:deco/ui/core/widgets/deco_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/couple.dart';
import '../core/themes/deco_theme_extension.dart';

class CreateCoupleRoomScreen extends StatefulWidget {
  const CreateCoupleRoomScreen({super.key});

  @override
  State<CreateCoupleRoomScreen> createState() => _CreateCoupleRoomScreenState();
}

class _CreateCoupleRoomScreenState extends State<CreateCoupleRoomScreen> {
  final _coupleService = CoupleService();
  String? code;

  @override
  void initState() {
    super.initState();
    _loadCode();
  }

  Future<void> _loadCode() async {
    final couple = await _coupleService.readMyCoupleByInvitor();
    if (!mounted) return;

    setState(() {
      code = couple?.code;
    });
  }

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F0FF), Color(0xFFFFFFFF)],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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

                Text(
                  '커플 방이 만들어졌어요!',
                  style: TextStyle(
                    color: decoTheme.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                Text(
                  '아래 코드를 상대방에게 공유해주세요 ✨',
                  style: TextStyle(
                    color: decoTheme.textSecondary,
                    fontSize: 16,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: AppColors.primary, width: 0.5),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 28,
                          offset: Offset(0, 18),
                          color: Color(0x1A000000),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        Text(
                          '초대코드',
                          style: TextStyle(
                            color: decoTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 0.5,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFF6F0FF), Color(0xFFFFFFFF)],
                              ),
                            ),
                            child: Text(
                              code ?? '-----',
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: DecoPrimaryButton(
                            label: '코드 복사하기',
                            onPressed: () {},
                            prefixIcon: Icon(Icons.copy_outlined),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
                  child: DecoOutlinedButton(
                    label: '다른 방법으로 공유하기',
                    onPressed: () {},
                    suffixIcon: Icon(Icons.share_outlined),
                    radius: 60,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBg,
                      ),
                      child: Text('완료', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),

                Text(
                  '상대방이 코드를 입력하면 자동으로 연결됩니다💕',
                  style: TextStyle(
                    color: decoTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
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
