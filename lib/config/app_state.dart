import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _onboardingDone = false;
  bool _signedIn = false;
  bool _coupleConnected = false;

  bool get onboardingDone => _onboardingDone;
  bool get signedIn => _signedIn;
  bool get coupleConnected => _coupleConnected;

  void setOnboardingDone(bool onboardingDone) {
    _onboardingDone = onboardingDone;
    notifyListeners();
  }

  void setSignedIn(bool signedIn) {
    _signedIn = signedIn;
    notifyListeners();
  }

  void setCoupleConnected(bool coupleConnected) {
    _coupleConnected = coupleConnected;
    notifyListeners();
  }
}