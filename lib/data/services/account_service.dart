import 'package:deco/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'couple_service.dart';
import 'firebase_auth_service.dart';

class AccountService {
  final FirebaseAuthService _authService;
  final CoupleService _coupleService;
  final UserService _userService;

  AccountService(
      this._authService,
      this._coupleService,
      this._userService,
      );

  Future<void> deleteAccount() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser == null) return;
    final uid = currentUser.uid;

    // 1. 커플 정리
    await _coupleService.detachUserFromCouples(uid);

    // 2. 유저 문서 삭제
    await _userService.deleteUser(uid);

    // 3. Auth 계정 삭제
    await _authService.deleteAccount();
  }
}