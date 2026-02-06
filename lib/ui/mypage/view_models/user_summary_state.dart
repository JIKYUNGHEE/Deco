import 'package:deco/ui/mypage/profile_edit_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/services/user_service.dart';

class UserSummaryState extends ChangeNotifier {
  final UserService _userService;

  UserSummaryState({
    UserService? userService,
  }) : _userService = userService ?? UserService();

  String? nickName = '';
  DateTime? birth;
  String? gender = '';
  String? introduce = '';
  BearColor? bearColor;

  Future<void> load() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser == null) return;
    final uid = currentUser.uid;
    final user = await _userService.getUserById(uid);
    if(user == null) return;

    nickName = user.nickname;
    birth = user.birth;
    gender = user.gender;
    introduce = user.introduce;
    bearColor = user.bearColor;
  }
}