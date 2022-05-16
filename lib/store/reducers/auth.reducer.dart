// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/store/actions/auth.action.dart';
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';

final Reducer<AuthMobileModel> authReducer = combineReducers<
    AuthMobileModel>(<AuthMobileModel Function(AuthMobileModel, dynamic)>[
  TypedReducer<AuthMobileModel, CodeSendPending>(_sendSms),
  TypedReducer<AuthMobileModel, VerificationFailed>(_verificationFailed),
  TypedReducer<AuthMobileModel, WrongSmsCodePending>(_wrongSmsCode),
  TypedReducer<AuthMobileModel, CodeAutoRetrievalTimeOut>(
      _codeRetrievalTimeOut),
  TypedReducer<AuthMobileModel, CheckSmsSuccess>(_checkSms),
]);

AuthMobileModel _sendSms(AuthMobileModel state, CodeSendPending action) {
  return AuthMobileModel(
      codeSend: true,
      verificationId: action.verificationId,
      forceResendingToken: action.forceResendingToken);
}

AuthMobileModel _checkSms(AuthMobileModel state, CheckSmsSuccess action) {
  return AuthMobileModel();
}

AuthMobileModel _verificationFailed(
    AuthMobileModel state, VerificationFailed action) {
  return AuthMobileModel(
    verificationFailed: action.exception
  );
}

AuthMobileModel _wrongSmsCode(
    AuthMobileModel state, WrongSmsCodePending action) {
  return AuthMobileModel(
    wrongSmsCode: true
  );
}

AuthMobileModel _codeRetrievalTimeOut(
    AuthMobileModel state, CodeAutoRetrievalTimeOut action) {
  return AuthMobileModel(
    timeIsOut: true,
    verificationId: action.verificationId
  );
}
