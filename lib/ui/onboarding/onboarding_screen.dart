import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/app_state.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('온보딩페이지'),
            TextButton(
              onPressed: () {
                context.read<AppState>().setOnboardingDone(true);
                context.go('/login');
              },
              child: Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
