// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/store/actions/auth.action.dart';
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';

final Reducer<AuthMobileModel> authReducer = combineReducers<
    AuthMobileModel>(<AuthMobileModel Function(AuthMobileModel, dynamic)>[
  TypedReducer<AuthMobileModel, CodeSendPending>(_sendSmsPending),
  TypedReducer<AuthMobileModel, CodeSendSuccess>(_sendSmsSuccess),
  TypedReducer<AuthMobileModel, VerificationFailed>(_verificationFailed),
  TypedReducer<AuthMobileModel, WrongSmsCodePending>(_wrongSmsCode),
  TypedReducer<AuthMobileModel, CodeAutoRetrievalTimeOut>(
      _codeRetrievalTimeOut),
  TypedReducer<AuthMobileModel, CheckSmsPending>(_checkSmsPending),
  TypedReducer<AuthMobileModel, CheckSmsSuccess>(_checkSmsSuccess),
  TypedReducer<AuthMobileModel, SetAuthTimer>(_setAuthTimer),
  TypedReducer<AuthMobileModel, AuthTimerIsOut>(_timerIsOut),
]);

AuthMobileModel _sendSmsPending(AuthMobileModel state, CodeSendPending action) {
  return AuthMobileModel(isSendSmsLoading: true);
}

AuthMobileModel _sendSmsSuccess(AuthMobileModel state, CodeSendSuccess action) {
  return AuthMobileModel(
      codeSend: true,
      isSendSmsLoading: state.isSendSmsLoading,
      verificationId: action.verificationId,
      forceResendingToken: action.forceResendingToken);
}

AuthMobileModel _checkSmsPending(
    AuthMobileModel state, CheckSmsPending action) {
  return AuthMobileModel(
      wrongSmsCode: state.wrongSmsCode,
      timeIsOut: state.timeIsOut,
      timer: state.timer,
      isSendSmsLoading: state.isSendSmsLoading,
      isCheckSmsLoading: true,
      verificationFailed: state.verificationFailed,
      verificationId: state.verificationId,
      forceResendingToken: state.forceResendingToken);
}

AuthMobileModel _checkSmsSuccess(
    AuthMobileModel state, CheckSmsSuccess action) {
  return AuthMobileModel();
}

AuthMobileModel _verificationFailed(
    AuthMobileModel state, VerificationFailed action) {
  return AuthMobileModel(
    forceResendingToken: state.forceResendingToken,
    verificationId: state.verificationId,
    verificationFailed: action.exception,
  );
}

AuthMobileModel _wrongSmsCode(
    AuthMobileModel state, WrongSmsCodePending action) {
  return AuthMobileModel(
      isSendSmsLoading: state.isSendSmsLoading,
      forceResendingToken: state.forceResendingToken,
      verificationId: state.verificationId,
      timer: state.timer,
      wrongSmsCode: true);
}

AuthMobileModel _codeRetrievalTimeOut(
    AuthMobileModel state, CodeAutoRetrievalTimeOut action) {

    return AuthMobileModel(
      timeIsOut: true,
      verificationId: action.verificationId,
      forceResendingToken: state.forceResendingToken,
    );

}

AuthMobileModel _setAuthTimer(AuthMobileModel state, SetAuthTimer action) {
  return AuthMobileModel(
      codeSend: state.codeSend,
      wrongSmsCode: state.wrongSmsCode,
      timeIsOut: state.timeIsOut,
      isSendSmsLoading: state.isSendSmsLoading,
      isCheckSmsLoading: state.isCheckSmsLoading,
      timer: action.timer,
      verificationFailed: state.verificationFailed,
      verificationId: state.verificationId,
      forceResendingToken: state.forceResendingToken);
}

AuthMobileModel _timerIsOut(AuthMobileModel state, AuthTimerIsOut action) {
  return AuthMobileModel(
      timeIsOut: true,
      timer: null,);
}

