// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sample_shop/common/services/user.service.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/user/user.model.dart';

// Получение профиля пользователя
Stream<void> getUserProfileEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetUserProfilePending)
      .switchMap((dynamic action) =>
          Stream<UserModel>.fromFuture(getUserProfile())
              .expand<dynamic>((UserModel user) =>
                  <dynamic>[GetUserProfileSuccess(user: user)])
              .handleError((dynamic e) => {print(e)}));
}

// Обновление учетной записи пользователя
Stream<void> updateUserProfileEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is UpdateProfilePending)
      .switchMap((dynamic action) =>
          Stream<UserModel>.fromFuture(updateUserProfile(action.user.toJson()))
              .expand<dynamic>((UserModel user) =>
                  <dynamic>[UpdateProfileSuccess(user: user)])
              .handleError((dynamic e) => {print(e)}));
}

// Добавление товара в избранное в профиль клиента
Stream<void> addProductToFavouritesEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is AddProductToFavoritePending)
      .switchMap((action) =>
          Stream<List<String>>.fromFuture(addProductToFavourites(action.id))
              .expand((List<String> favourites) =>
                  [AddProductToFavoriteSuccess(favorits: favourites)])
              .handleError((e) => {print('error add to favourites epic: $e')}));
}

// Удаление товара из избранного в профиле клиента
Stream<void> deleteProductFromFavouritesEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is DeleteProductFromFavouritesPending)
      .switchMap((action) => Stream<List<String>>.fromFuture(
              removeProductFromFavourites(action.id))
          .expand((List<String> favourites) =>
              [DeleteProductFromFavouritesSuccess(favorits: favourites)])
          .handleError(
              (e) => {print('error delete from favourites epic: $e')}));
}

// Stream<void> getUserEpic(Stream<dynamic> actions, EpicStore<dynamic> store){
//   return actions
//       .where((dynamic action) => action is GetUsersPending)
//       .switchMap((dynamic action) =>
//         Stream<List<UserModel>>.fromFuture(getUsers())
//           .expand<dynamic>((List<UserModel> users) =>  <dynamic>[GetUsersSuccess(users)])
//             .handleError((dynamic e) => {print(e)}));
// }
