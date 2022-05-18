// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sample_shop/store/actions/auth.action.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/auth/user_token.model.dart';
import 'package:sample_shop/common/localStorage/auth_token_storage_options.dart';
import 'package:sample_shop/common/services/auth.service.dart';

Stream<void> authUserGetTokenEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is GetUserTokenPending)
      .switchMap((action) => Stream<UserTokenModel>.fromFuture(
              authService.getTokenWithUserFirebaseId(action.uid, action.phone))
          .switchMap((UserTokenModel result) => Stream<void>.fromFuture(
              authTokenLocalStorage.addTokenToLocalStorage(result.token)))
          .expand((value) => <dynamic>[
                // сброс стейта авторизации
                CheckSmsSuccess(),
                // запрос профиля пользователя
                GetUserProfilePending()
              ]))
      .handleError((e) => print('set token error: $e'));
}

Stream<void> unauthorizedUserEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is UnauthorizedUser)
      .switchMap((action) => Stream<void>.fromFuture(
          authTokenLocalStorage.deleteTokenFromLocalStorage()))
      .expand((element) => [ClearUserProfile()])
      .handleError((e) => print('clear user data error: $e'));
}

//
// // Проверка номера, отправка смс
// Stream<void> authSendSmsEpic(
//     Stream<dynamic> actions, EpicStore<dynamic> store) {
//   return actions.where((dynamic action) => action is SendSmsPending).switchMap(
//       (action) => Stream<AuthUserFromFirebase>.fromFuture(
//               AuthService().signInWithPhoneSendSms(action.phone))
//           // преобразует каждый елемент потока в последовательность елементов
//           .expand((AuthUserFromFirebase result) => <dynamic>[
//                 if (result.verificationId != null)
//                   SendSmsSuccess(result: result),
//               ])
//           .handleError((dynamic e) => {print('error: $e')}));
// }
//
// // Проверка номера, проверка смс
// Stream<void> authCheckSmsEpic(
//     Stream<dynamic> actions, EpicStore<dynamic> store) {
//   return actions.where((dynamic action) => action is CheckSmsPending).switchMap(
//       (action) => Stream<AuthUserFromFirebase>.fromFuture(AuthService()
//               .signInWithPhoneCheckSms(action.verificationId, action.smsCode))
//           // преобразует каждый елемент потока в последовательность елементов
//           .expand((AuthUserFromFirebase result) => <dynamic>[
//                 CheckSmsSuccess(result: result),
//               ])
//           .handleError((dynamic e) => {print('error: $e')}));
// }
