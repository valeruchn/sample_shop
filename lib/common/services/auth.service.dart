//Package imports:
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';

//Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/common/helpers/utils/close_pin_code_modal.dart';
import 'package:sample_shop/common/localStorage/auth_token_storage_options.dart';
import 'package:sample_shop/store/actions/auth.action.dart';
import 'package:sample_shop/store/models/auth/user_token.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/store.dart';
import 'package:firebase_auth/firebase_auth.dart';

final AuthService authService = AuthService(authTokenLocalStorage, store);

class AuthService {
  AuthService(this.localService, this.store);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthTokenLocalStorage localService;
  final Store<AppState> store;

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
      store.dispatch(CodeSendPending());
      await _auth.verifyPhoneNumber(
          phoneNumber: mobile,
          timeout: const Duration(seconds: 60),
          forceResendingToken: store.state.auth.forceResendingToken,
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

  // Проверка отправленного смс
  Future<void> signInWithPhoneCheckSms(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      store.dispatch(CheckSmsPending());
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      final result = await _auth.signInWithCredential(credential);
      if (result.user != null) {
        // закрытие модального окна с вводом пин кода, если оно открыто
        closePinCodeModal();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        // print('wrong sms');
        store.dispatch(WrongSmsCodePending());
      }
    }
  }

  void _codeSend(String verificationId, int? forceResendingToken) {
    // print('code send');
    store.dispatch(CodeSendSuccess(
        verificationId: verificationId,
        forceResendingToken: forceResendingToken));
  }

  void _verificationCompleted(AuthCredential authCredential) {
    _auth.signInWithCredential(authCredential);
  }

  void _verificationFailed(FirebaseAuthException authException) {
    // print('verification failed');
    store.dispatch(VerificationFailed(exception: authException.code));
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    // print('verification time out');
    // store.dispatch(CodeAutoRetrievalTimeOut(verificationId: verificationId));
  }
}
