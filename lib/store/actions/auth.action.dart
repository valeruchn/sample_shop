// Project imports:
// import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';

class GetUserTokenPending {
  GetUserTokenPending({required this.uid, required this.phone});

  String uid;
  String phone;
}
// сброс токена в хранилище и обнуление профиля в стейт
class UnauthorizedUser {}

//
// class SendSmsPending {
//   SendSmsPending({required this.phone});
//
//   String phone;
// }
//
// class SendSmsSuccess {
//   SendSmsSuccess({required this.result});
//
//   AuthUserFromFirebase result;
// }
//
// class CheckSmsPending {
//   String verificationId;
//   String smsCode;
//
//   CheckSmsPending({required this.smsCode, required this.verificationId});
// }
//
// class CheckSmsSuccess {
//   CheckSmsSuccess({required this.result});
//
//   AuthUserFromFirebase result;
// }
