import 'package:deco/config/app_state.dart';
import 'package:deco/ui/calendar/calendar_screen.dart';
import 'package:deco/ui/connect/complete_couple_screen.dart';
import 'package:deco/ui/connect/couple_connect_screen.dart';
import 'package:deco/ui/connect/create_couple_room_screen.dart';
import 'package:deco/ui/core/ui/frame_page.dart';
import 'package:deco/ui/course/create/create_course_screen.dart';
import 'package:deco/ui/course/create/create_place_screen.dart';
import 'package:deco/ui/debug/theme_preview_page.dart';
import 'package:deco/ui/connect/enter_invitation_code_screen.dart';
import 'package:deco/ui/home/home_screen.dart';
import 'package:deco/ui/login/login_screen.dart';
import 'package:deco/ui/mypage/couple_edit_screen.dart';
import 'package:deco/ui/mypage/mypage_screen.dart';
import 'package:deco/ui/onboarding/onboarding_screen.dart';
import 'package:deco/ui/terms/terms_agree_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/auth/email_verify_screen.dart';
import '../ui/auth/signup_screen.dart';
import '../ui/course/list/course_screen.dart';
import '../ui/mypage/profile_edit_screen.dart';

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
    initialLocation: '/onboarding',
    refreshListenable: appState,
    redirect: (context, state) {
      final loc = state.matchedLocation;

      if (!appState.initialized) return null;

      if(loc == '/theme') return null;

      final inOnboarding = loc.startsWith('/onboarding');
      final inLogin = loc.startsWith('/login');
      final inTerms = loc.startsWith('/terms');
      final inSignup = loc.startsWith('/signup');
      final inVerify = loc.startsWith('/verify-email');
      final inConnectFlow = loc.startsWith('/connect') ||
          loc.startsWith('/create-room') ||
          loc.startsWith('/enter-code') ||
          loc.startsWith('/connect-complete');

      final authFree = inLogin || inTerms || inSignup;
      final signedIn = appState.signedIn;
      final verified = appState.emailVerified;
      final hasCouple = appState.hasCouple;

      final inShell = loc == '/home' || loc =='/course' || loc == '/calendar' || loc == '/mypage';

      if(!appState.onboardingDone) {
        return inOnboarding ? null : '/onboarding';
      }

      if (!signedIn) {
        return authFree ? null : '/login';
      }

      if (!verified) {
        return inVerify ? null : '/verify-email';
      }

      if (signedIn && verified && !hasCouple) {
        return inConnectFlow ? null : '/connect';
      }

      if (signedIn && verified && hasCouple && inConnectFlow) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/theme', builder: (context, state) => ThemePreviewPage()),
      GoRoute(path: '/onboarding', builder: (context, state) => OnboardingScreen()),
      GoRoute(path: '/terms', builder: (context, state) => TermsAgreeScreen()),
      GoRoute(path: '/signup', builder: (context, state) => SignupScreen()),
      GoRoute(
          path: '/verify-email', builder: (context, state) {
        final email = state.extra as String?;
        return EmailVerifyScreen(email: email);
      }),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/connect', builder: (context, state) => CoupleConnectScreen()),
      GoRoute(path: '/create-room', builder: (context, state) => CreateCoupleRoomScreen()),
      GoRoute(path: '/enter-code', builder: (context, state) => EnterInvitationCodeScreen()),
      GoRoute(path: '/connect-complete', builder: (context, state) => CompleteCoupleScreen()),
      GoRoute(path: '/create-course', builder: (context, state) => CreateCourseScreen()),
      GoRoute(path: '/create-place', parentNavigatorKey: _rootNavigatorKey, builder: (context, state) => CreatePlaceScreen()),
      GoRoute(path: '/profile/edit', parentNavigatorKey: _rootNavigatorKey, builder: (context, state) => ProfileEditScreen()),
      GoRoute(path: '/couple/edit', parentNavigatorKey: _rootNavigatorKey, builder: (context, state) => CoupleEditScreen()),
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
                  return CourseScreen(initialTab: state.uri.queryParameters['tab'],);
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
                  return MyPageScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
