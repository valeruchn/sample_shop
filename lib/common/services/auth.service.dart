//Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/common/localStorage/auth_token_storage_options.dart';
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
import 'package:sample_shop/store/models/auth/user_token.model.dart';

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

  // Future<AuthUserFromFirebase> signInWithPhoneSendSms(String mobile) async {
  //   // токен повторной отпраки смс
  //   int? _forceResendingToken;
  //   String _verificationId = '';
  //
  //   try {
  //     await _auth.verifyPhoneNumber(
  //         // телефон, полученый из формы
  //         phoneNumber: mobile,
  //         // Время, которое плагин будет ожидать до обработки
  //         timeout: const Duration(seconds: 60),
  //         // Токен для повторной отправки, если он указан, то при
  //         // повторном нажатии отправить смс, будет повторно выслан тот же код
  //         forceResendingToken: _forceResendingToken,
  //         // После отправки кода, ожидание и обработка ввода пин кода
  //         codeSent: (String verificationId, int? forceResendingToken) {
  //           // устанавливаем токен повторной отправки
  //           _forceResendingToken = forceResendingToken;
  //           _verificationId = verificationId;
  //         },
  //         // После успешной проверки кода
  //         verificationCompleted: (AuthCredential authCredential) {
  //           _auth
  //               .signInWithCredential(authCredential)
  //               .then((UserCredential result) {
  //             // озвращаем результат
  //             return AuthUserFromFirebase.success(result.user!);
  //           });
  //         },
  //         // При ошибках проверки кода
  //         verificationFailed: (FirebaseAuthException authException) {},
  //         // Действие, после истечения срока таймаута
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           _verificationId = verificationId;
  //         });
  //   } catch (e) {
  //     return AuthUserFromFirebase.fail('error: ${e.toString()}');
  //   }
  //   return AuthUserFromFirebase.init();
  // }
  //
  // // Проверка отправленного смс
  // Future<AuthUserFromFirebase> signInWithPhoneCheckSms(
  //     String verificationId, String smsCode) async {
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: smsCode);
  //     UserCredential result = await _auth.signInWithCredential(credential);
  //     print('checkcode: ${result.user}');
  //     return AuthUserFromFirebase.success(result.user!);
  //   } catch (e) {
  //     return AuthUserFromFirebase.fail('error: ${e.toString()}');
  //   }
  // }


}
