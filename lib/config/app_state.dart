import 'dart:async';

import 'package:deco/data/services/couple_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  static const String _onboardingKey = 'onboarding_done';
  final _coupleService = CoupleService();

  bool _initialized = false;
  bool get initialized => _initialized;

  bool _onboardingDone = false;
  bool get onboardingDone => _onboardingDone;

  bool _signedIn = false;
  bool get signedIn => _signedIn;

  bool _emailVerified = false;
  bool get emailVerified => _emailVerified;

  bool _hasCouple = false;
  bool get hasCouple => _hasCouple;

  StreamSubscription<User?>? _authSub;

  Future<void> loadCoupleState(String uid) async {
    final coupleId = await _coupleService.findMyCoupleId(uid);
    final next = (coupleId ?? '').isNotEmpty;

    if (_hasCouple != next) {
      _hasCouple = next;
      notifyListeners();
    }
  }

  void _setFromUser(User? user) async {
    final nextSignedIn = user != null;
    final nextVerified = user?.emailVerified ?? false;

    var changed = false;
    if (_signedIn != nextSignedIn) {
      _signedIn = nextSignedIn;
      changed = true;
    }
    if (_emailVerified != nextVerified) {
      _emailVerified = nextVerified;
      changed = true;
    }

    if (user != null) {
      await loadCoupleState(user.uid);
    } else {
      _hasCouple = false;
    }

    if (changed) notifyListeners();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final firstRun = prefs.getBool('has_run_before') ?? false;

    if (!firstRun) {
      await FirebaseAuth.instance.signOut();
      await prefs.setBool(_onboardingKey, false);
      await prefs.setBool('has_run_before', true);
    }

    _onboardingDone = prefs.getBool(_onboardingKey) ?? false;

    _setFromUser(FirebaseAuth.instance.currentUser);

    _authSub = FirebaseAuth.instance.userChanges().listen(_setFromUser);
    _initialized = true;
    notifyListeners();
  }

  Future<void> setOnboardingDone(bool onboardingDone) async {
    _onboardingDone = onboardingDone;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, onboardingDone);
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
