import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deco/domain/models/couple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  FirebaseAuthService() : _auth = FirebaseAuth.instance {
    _auth.setLanguageCode('kr');
  }

  Future<void> signUpWithEmail({
    required String nickname,
    required String email,
    required String password,
  }) async {
    String? errorMessage;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'weak-password':
          errorMessage = '취약한 패스워드입니다. 최소 6자리 이상의 문자를 입력하세요.';
          break;
        case 'email-already-in-use':
          errorMessage = '이미 사용 중인 이메일입니다. 다른 이메일을 입력하세요.';
          break;
        case 'invalid-email':
          errorMessage = '유효하지 않은 이메일입니다.';
          break;
        default:
          errorMessage = error.message ?? '알 수 없는 에러 발생';
      }
    } catch (error) {
      errorMessage = '알 수 없는 에러 발생';
    }

    if (errorMessage != null) {
      print(errorMessage);
      throw Exception(errorMessage);
    }

    await _fs.collection('users').doc(_auth.currentUser?.uid).set({
      'email': email,
      'nickname': nickname,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _auth.currentUser?.sendEmailVerification();
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    String? errorMessage;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          errorMessage = '해당 이메일로 가입된 사용자가 없습니다.';
          break;
        case 'wrong-password':
          errorMessage = '비밀번호가 올바르지 않습니다.';
          break;
        case 'invalid-email':
          errorMessage = '유효하지 않은 이메일입니다.';
          break;
        case 'invalid-credential':
          errorMessage = '비밀번호가 올바르지 않거나 유효하지 않은 이메일입니다.';
          break;
        default:
          errorMessage = error.message ?? '알 수 없는 오류가 발생했습니다.';
      }
    } catch (error) {
      errorMessage = '알 수 없는 오류가 발생했습니다.';
    }

    if (errorMessage != null) {
      throw Exception(errorMessage);
    }
  }

  Future<void> resetPassword(String email) async {
    // 비밀번호 재설정 코드 작성
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    //계정삭제 코드 작성
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch(e) {
      if(e.code == 'requires-recent-login') {
        rethrow;
      } else {
        throw Exception('탈퇴과정에 문제가 있습니다. ${e.toString()}');
      }
    } catch(e) {
      print(e);
      throw Exception('탈퇴과정에 문제가 있습니다. ${e.toString()}');
    }
  }

  Future<void> reauthenticateWithPassword(String password) async {
    final user = _auth.currentUser;
    final email = user?.email;

    if (user == null || email == null) {
      throw Exception('로그인 정보가 없습니다.');
    }

    final cred = EmailAuthProvider.credential(email: email, password: password);
    await user.reauthenticateWithCredential(cred);
  }

  Future<void> updateCoupleNickname(Couple couple, String nickname1, String nickname2) async {  //TODO. UserService로 옮기기 or CoupleService
    await _fs.collection('users').doc(couple.invitee).update({
      'nickname': nickname1,
    });

    await _fs.collection('users').doc(couple.invitor).update({
      'nickname': nickname2,
    });
  }
}
