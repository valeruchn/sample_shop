// Package imports:
// import 'package:redux/redux.dart';
// // Project imports:
// import 'package:sample_shop/store/actions/auth.action.dart';
// import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
//
//
//
// final Reducer<AuthUserFromFirebase> authReducer =
// combineReducers<AuthUserFromFirebase>(<AuthUserFromFirebase Function(AuthUserFromFirebase, dynamic)>[
//   TypedReducer<AuthUserFromFirebase, SendSmsSuccess>(_sendSms),
//   TypedReducer<AuthUserFromFirebase, CheckSmsSuccess>(_checkSms),
// ]);
//
// AuthUserFromFirebase _sendSms (AuthUserFromFirebase authModel, SendSmsSuccess action) {
//   return action.result;
// }
//
// AuthUserFromFirebase _checkSms (AuthUserFromFirebase authModel, CheckSmsSuccess action) {
//   return action.result;
// }