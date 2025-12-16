import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/app_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('로그인페이지'),
            TextButton(
              onPressed: () {
                context.read<AppState>().setSignedIn(true);
                context.go('/connect');
              },
              child: Text('커플연결'),
            ),
          ],
        ),
      ),
    );
  }
}
