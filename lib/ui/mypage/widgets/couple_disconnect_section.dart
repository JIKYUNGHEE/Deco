import 'package:deco/data/services/couple_service.dart';
import 'package:deco/ui/core/widgets/deco_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoupleDisconnectSection extends StatelessWidget {
  final _coupleService = CoupleService();
  CoupleDisconnectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoCard(
      child: Column(
        children: [
          Text(
            '커플 연결 해제',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          const Text(
            '커플 연결을 해제하면 상대방과 공유된 모든 데이터가 사라집니다. 신중하게 진행해주세요.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Color(0xFF9B9B9B)),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => _confirmDeleteCoupleAccount(context),
            child: const Text('커플 연결 해제하기',
                style: TextStyle(
                    color: Color(0xFFE5484D), fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteCoupleAccount(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('정말 커플 연결을 해지 하시겠어요?'),
        content: const Text('다시 커플 연결을 할 수 없어요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('커플 해지'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    String uid = FirebaseAuth.instance.currentUser!.uid;
    String? coupleId = await _coupleService.findMyCoupleId(uid);
    if(coupleId == null) return;
    _coupleService.deleteCoupleAccount(coupleId);

    if (!context.mounted) return;
    context.go('/login');
  }
}

