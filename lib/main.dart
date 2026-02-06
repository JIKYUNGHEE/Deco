import 'package:deco/config/app_state.dart';
import 'package:deco/routing/router.dart';
import 'package:deco/ui/core/themes/deco_theme.dart';
import 'package:deco/viewmodels/couple_summary_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final appState = AppState();
  await appState.init();

  initRouter(appState);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: appState),
      ChangeNotifierProvider(create: (_) => CoupleSummaryState()..load())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [Locale('ko', 'KR'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: DecoTheme.light(),
      darkTheme: DecoTheme.dark(),
      themeMode: ThemeMode.system,
      themeAnimationDuration: Duration.zero,
      debugShowCheckedModeBanner: false,
    );
  }
}
