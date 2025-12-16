import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/app_state.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('커플연결페이지'),
            TextButton(
              onPressed: () {
                context.read<AppState>().setCoupleConnected(true);
                context.go('/home');
              },
              child: Text('홈으로'),
            ),
          ],
        ),
      ),
    );
  }
}
