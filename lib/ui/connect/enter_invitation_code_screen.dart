import 'package:deco/data/services/couple_service.dart';
import 'package:deco/domain/models/couple.dart';
import 'package:deco/ui/core/widgets/deco_outlined_button.dart';
import 'package:deco/ui/core/widgets/deco_primary_button.dart';
import 'package:deco/viewmodels/couple_summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'widgets/couple_code_input_field.dart';
import '../core/themes/app_colors.dart';
import '../core/themes/deco_theme_extension.dart';

class EnterInvitationCodeScreen extends StatefulWidget {
  const EnterInvitationCodeScreen({super.key});

  @override
  State<EnterInvitationCodeScreen> createState() =>
      _EnterInvitationCodeScreenState();
}

class _EnterInvitationCodeScreenState extends State<EnterInvitationCodeScreen> {
  final _coupleService = CoupleService();

  final _formKey = GlobalKey<FormState>();
  List<String?> checkCodeList = List.filled(5, null);
  bool checkAllCodeFilled = false;

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

    return Scaffold(
      body: Container(
        child: SafeArea(
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

              Text(
                '초대 코드 입력',
                style: TextStyle(
                  color: decoTheme.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(height: 24),

              Text(
                '연인이 보낸 5자리 초대 코드를 입력하면\n서로의 데이트 코스를 함께 볼 수 있어요.',
                style: TextStyle(color: decoTheme.textSecondary, fontSize: 14),
              ),

              SizedBox(height: 16),

              _CoupleIllustCard(),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return CodeInputTextField(
                          checkCodeCallback: (value) {
                            checkCodeList[index] = value;
                            bool isAll = checkCodeList.every(
                                  (v) => (v != null && v != ''),
                            );

                            if(isAll != checkAllCodeFilled){
                              setState(() {
                                checkAllCodeFilled = isAll;
                              });
                            }

                          },
                        );
                      }),
                    ),

                    SizedBox(height: 32),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      child: !checkAllCodeFilled
                          ? SizedBox(
                              width: double.infinity,
                              height: 58,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: decoTheme.disabledText,
                                ),
                                child: Text(
                                  '연결하기',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          : DecoPrimaryButton(label: '연결하기', onPressed: () {
                            checkCoupleCode(context);
                      }, radius: 60, height: 58,),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray200),
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.gray50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('유효하지 않은 코드인가요?'),
                      Text(
                        '코드는 일정 시간이 지나면 만료될 수 있어요. ',
                        style: TextStyle(
                          color: decoTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  '아직 연인과 함께 쓰지 않아도 괜찮다면,',
                  style: TextStyle(
                    color: decoTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 4,
                ),
                child: DecoOutlinedButton(
                  label: '혼자 먼저 데이트 기록 시작하기',
                  onPressed: () {
                    context.go('/home');
                  },
                  height: 58,
                  radius: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkCoupleCode(BuildContext context) async {
    String code = checkCodeList.join();
    Couple? couple = await _coupleService.readMyCoupleByCode(code);
    if(couple != null && code == couple.code) {
        context.read<CoupleSummaryState>().load();
        context.push('/connect-complete');
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('코드가 맞지 않습니다.')));
      }
    }
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
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;

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
              Opacity(
                opacity: 0.5,
                child: SvgPicture.asset(
                  'assets/illustrations/purple-bear.svg',
                  width: 132,
                ),
              ),
            ],
          ),

          Positioned(
            child: ScaleTransition(
              scale: Tween(
                begin: 0.85,
                end: 1.1,
              ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller),
              child: Text(
                '--?--',
                style: TextStyle(fontSize: 16, color: decoTheme.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
