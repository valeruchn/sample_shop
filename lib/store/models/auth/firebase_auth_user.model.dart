class AuthMobileModel {
  AuthMobileModel(
      {this.codeSend = false,
      this.wrongSmsCode = false,
      this.timeIsOut = false,
      this.verificationFailed,
      this.verificationId,
      this.forceResendingToken});

  bool codeSend;
  bool wrongSmsCode;
  bool timeIsOut;
  String? verificationFailed;
  String? verificationId;
  int? forceResendingToken;
}
