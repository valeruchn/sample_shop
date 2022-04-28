// Package imports:
// import 'package:redux_epics/redux_epics.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:sample_shop/common/services/auth.service.dart';
//
// // Project imports:
// import 'package:sample_shop/store/actions/auth.action.dart';
// import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
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
