import 'package:deco/config/app_state.dart';
import 'package:deco/routing/router.dart';
import 'package:deco/ui/core/themes/deco_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final appState = AppState();
  initRouter(appState);

  runApp(ChangeNotifierProvider.value(value: appState, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
