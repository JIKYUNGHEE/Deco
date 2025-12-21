import 'package:deco/config/app_state.dart';
import 'package:deco/ui/calendar/calendar_screen.dart';
import 'package:deco/ui/connect/connect_screen.dart';
import 'package:deco/ui/core/ui/frame_page.dart';
import 'package:deco/ui/debug/theme_preview_page.dart';
import 'package:deco/ui/home/home_screen.dart';
import 'package:deco/ui/login/login_screen.dart';
import 'package:deco/ui/mypage/mypage_screen.dart';
import 'package:deco/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/course/list/course_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _homeTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final GlobalKey<NavigatorState> _courseTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'courseTab');
final GlobalKey<NavigatorState> _calenderTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'calendarTab');
final GlobalKey<NavigatorState> _mypageTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'mypageTab');

late final GoRouter appRouter;

void initRouter(AppState appState) {
  appRouter = createRouter(appState);
}


GoRouter createRouter(AppState appState) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/theme',
    refreshListenable: appState,
    redirect: (context, state) {
      final loc = state.matchedLocation;

      if(loc == '/theme') return null;

      final inOnboarding = loc == '/onboarding';
      final inLogin = loc == '/login';
      final inConnect = loc == '/connect';

      final inShell = loc == '/home' || loc =='/course' || loc == '/calendar' || loc == '/mypage';

      if(!appState.onboardingDone) {
        return inOnboarding ? null : '/onboarding';
      }

      if(!appState.signedIn) {
        return inLogin ? null : '/login';
      }

      if(!appState.coupleConnected) {
        return inConnect ? null : '/connect';
      }

      if(inOnboarding || inLogin || inConnect) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/theme', builder: (context, state) => ThemePreviewPage()),
      GoRoute(path: '/onboarding', builder: (context, state) => Onboarding()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/connect', builder: (context, state) => ConnectScreen()),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, navigationShell) {
          return FramePage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return HomeScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _courseTabNavigatorKey,
            routes: [
              GoRoute(
                path: '/course',
                builder: (context, state) {
                  return CourseScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _calenderTabNavigatorKey,
            routes: [
              GoRoute(
                path: '/calendar',
                builder: (context, state) {
                  return CalendarScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _mypageTabNavigatorKey,
            routes: [
              GoRoute(
                path: '/mypage',
                builder: (context, state) {
                  return MypageScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
