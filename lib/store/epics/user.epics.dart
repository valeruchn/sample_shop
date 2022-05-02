// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sample_shop/common/services/user.service.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/user/user.model.dart';


// Stream<void> getUserEpic(Stream<dynamic> actions, EpicStore<dynamic> store){
//   return actions
//       .where((dynamic action) => action is GetUsersPending)
//       .switchMap((dynamic action) =>
//         Stream<List<UserModel>>.fromFuture(getUsers())
//           .expand<dynamic>((List<UserModel> users) =>  <dynamic>[GetUsersSuccess(users)])
//             .handleError((dynamic e) => {print(e)}));
// }

// Получение профиля пользователя
Stream<void> getUserProfileEpic(Stream<dynamic> actions, EpicStore<dynamic> store){
  return actions
      .where((dynamic action) => action is GetUserProfilePending)
      .switchMap((dynamic action) =>
      Stream<UserModel>.fromFuture(getUserProfile())
          .expand<dynamic>((UserModel user) =>  <dynamic>[GetUserProfileSuccess(user: user)])
          .handleError((dynamic e) => {print(e)}));
}

// Создание учетной записи пользователя
// Stream<void> registrationUserEpic(Stream<dynamic> actions, EpicStore<dynamic> store){
//   return actions
//       .where((dynamic action) => action is RegistrationUserPending)
//       .switchMap((dynamic action) =>
//       Stream<UserModel>.fromFuture(registrationUser(action.user.toJson()))
//           .expand<dynamic>((UserModel user) =>  <dynamic>[RegistrationUserSuccess(user: user)])
//           .handleError((dynamic e) => {print(e)}));
// }

// Обновление учетной записи пользователя
Stream<void> updateUserProfileEpic(Stream<dynamic> actions, EpicStore<dynamic> store){
  return actions
      .where((dynamic action) => action is UpdateProfilePending)
      .switchMap((dynamic action) =>
      Stream<UserModel>.fromFuture(updateUserProfile(action.user.toJson()))
          .expand<dynamic>((UserModel user) =>  <dynamic>[UpdateProfileSuccess(user: user)])
          .handleError((dynamic e) => {print(e)}));
}