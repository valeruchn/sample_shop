class AuthMobileModel {
  AuthMobileModel(
      {this.codeSend = false,
      this.wrongSmsCode = false,
      this.timeIsOut = false,
      this.isCheckSmsLoading = false,
      this.isSendSmsLoading = false,
      this.timer,
      this.verificationFailed,
      this.verificationId,
      this.forceResendingToken});

  bool codeSend;
  bool wrongSmsCode;
  bool timeIsOut;
  bool isSendSmsLoading;
  bool isCheckSmsLoading;
  int? timer;
  String? verificationFailed;
  String? verificationId;
  int? forceResendingToken;
}
