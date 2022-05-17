// Project imports:
// import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';

class GetUserTokenPending {
  GetUserTokenPending({required this.uid, required this.phone});

  String uid;
  String phone;
}

// сброс токена в хранилище и обнуление профиля в стейт
class UnauthorizedUser {}

class CodeSendPending{}

class CodeSendSuccess {
  CodeSendSuccess(
      {required this.verificationId, this.forceResendingToken});

  String verificationId;
  int? forceResendingToken;
}

class VerificationFailed{
  VerificationFailed({required this.exception});
  String exception;
}

class WrongSmsCodePending{}

class CodeAutoRetrievalTimeOut{
  CodeAutoRetrievalTimeOut({required this.verificationId});
  String verificationId;
}

class CheckSmsPending{}
class CheckSmsSuccess{}

class EndAuthLoading{}

class SetAuthTimer{
  SetAuthTimer({this.timer});
  int? timer;
}

class AuthTimerIsOut{}
