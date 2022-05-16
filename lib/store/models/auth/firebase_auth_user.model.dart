class AuthMobileModel {
  AuthMobileModel(
      {this.codeSend = false,
      this.wrongSmsCode = false,
      this.verificationFailed,
      this.verificationId,
      this.forceResendingToken});

  bool codeSend;
  bool wrongSmsCode;
  String? verificationFailed;
  String? verificationId;
  int? forceResendingToken;
}
