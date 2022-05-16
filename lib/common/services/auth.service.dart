//Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/common/localStorage/auth_token_storage_options.dart';
import 'package:sample_shop/store/actions/auth.action.dart';
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
import 'package:sample_shop/store/models/auth/user_token.model.dart';
import 'package:sample_shop/store/store.dart';

final AuthService authService = AuthService(authTokenLocalStorage);

class AuthService {
  AuthService(this.localService);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthTokenLocalStorage localService;

  Future<UserTokenModel> getTokenWithUserFirebaseId(
      String uid, String phone) async {
    try {
      final Response<dynamic> res = await api.dio.post('/auth/user',
          data: <String, dynamic>{'uid': uid, 'phone': phone});
      final Map<String, dynamic> token = res.data;
      return UserTokenModel.fromJson(token);
    } catch (e) {
      print('auth error: $e');
    }
    return UserTokenModel(token: '');
  }

  void logOut() async {
    await localService.deleteTokenFromLocalStorage();
    await _auth.signOut();
  }

  Future<void> signInWithPhoneSendSms(String mobile) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: mobile,
          timeout: const Duration(seconds: 60),
          // forceResendingToken: _forceResendingToken,
          codeSent: _codeSend,
          // После успешной проверки кода
          verificationCompleted: _verificationCompleted,
          // При ошибках проверки кода
          verificationFailed: _verificationFailed,
          // Действие, после истечения срока таймаута
          codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
    } catch (e) {
      print('auth phone service error: $e ');
    }
  }

  void _codeSend(String verificationId, int? forceResendingToken) {
    store.dispatch(CodeSendPending(
        verificationId: verificationId,
        forceResendingToken: forceResendingToken));
  }

  void _verificationCompleted(AuthCredential authCredential) {
    _auth.signInWithCredential(authCredential);
  }

  void _verificationFailed(FirebaseAuthException authException) {
    store.dispatch(VerificationFailed(exception: authException.code));
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    store.dispatch(CodeAutoRetrievalTimeOut(verificationId: verificationId));
  }

  // // Проверка отправленного смс
  Future<void> signInWithPhoneCheckSms(
      String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    final result = await _auth.signInWithCredential(credential).catchError((e) {
      if (e.code == 'invalid-verification-id') {
        store.dispatch(WrongSmsCodePending());
      }
    });
    if (result.user != null) {
      store.dispatch(CheckSmsSuccess());
    }
  }
}
