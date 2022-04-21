import 'package:firebase_auth/firebase_auth.dart';

class AuthUserFromFirebase {

  AuthUserFromFirebase.init();

  AuthUserFromFirebase.codeSend(String verificationId, int? forceResendingToken) {
    status = 1;
    verificationId = verificationId;
    forceResendingToken = forceResendingToken;
  }

  AuthUserFromFirebase.success(User user) {
    id = user.uid;
    phone = user.phoneNumber;
    status = 2;
  }

  AuthUserFromFirebase.fail(String? authException) {
    status = 3;
    authException = authException;
  }

  int status = 0;
  String id = '';
  String? phone;
  String? authException = '';
  String? verificationId = '';
  int? forceResendingToken = 0;
}
