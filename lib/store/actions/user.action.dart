import 'package:sample_shop/store/models/user/user.model.dart';

class GetUserProfilePending {}

class GetUserProfileSuccess {
  GetUserProfileSuccess({required this.user});

  final UserModel user;
}

class UpdateProfilePending {
  UpdateProfilePending({required this.user});

  final UserModel user;
}

class UpdateProfileSuccess {
  UpdateProfileSuccess({required this.user});

  final UserModel user;
}

class ClearUserProfile {}

// class GetUsersPending {}
//
// class GetUsersSuccess {
//   const GetUsersSuccess(this.users);
//
//   final List<UserModel> users;
// }

// class RegistrationUserPending {
//   RegistrationUserPending({required this.user});
//
//   final UserModel user;
// }
//
// class RegistrationUserSuccess {
//   RegistrationUserSuccess({required this.user});
//
//   final UserModel user;
// }
