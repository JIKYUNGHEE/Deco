import 'package:deco/config/app_state.dart';
import 'package:deco/routing/router.dart';
import 'package:deco/ui/core/themes/deco_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();
  initRouter(appState);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider.value(value: appState, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: DecoTheme.light(),
      darkTheme: DecoTheme.dark(),
      themeMode: ThemeMode.system,
      themeAnimationDuration: Duration.zero,
    );
  }
}
