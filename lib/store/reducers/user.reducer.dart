// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/user/user.model.dart';

final Reducer<UserModel> userReducer =
//return state
    combineReducers<UserModel>(
        // Массив с функциями, которые принимают стейт и динамический тип(екшен) и возвращает стейт
        <UserModel Function(UserModel, dynamic)>[
      TypedReducer<UserModel, GetUserProfileSuccess>(_getUserProfile),
      // TypedReducer<UserModel, RegistrationUserSuccess>(_userRegistration),
      TypedReducer<UserModel, UpdateProfileSuccess>(_updateUserProfile),
      TypedReducer<UserModel, ClearUserProfile>(_clearUserProfile)
    ]);

UserModel _getUserProfile(UserModel user, GetUserProfileSuccess action) {
  return action.user;
}

// UserModel _userRegistration(UserModel user, RegistrationUserSuccess action) {
//   return action.user;
// }

UserModel _updateUserProfile(UserModel user, UpdateProfileSuccess action) {
  return action.user;
}

UserModel _clearUserProfile(UserModel user, ClearUserProfile action) {
  return UserModel(phone: '');
}
