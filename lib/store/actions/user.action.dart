import 'package:sample_shop/store/models/user/user.model.dart';

class GetUsersPending {}

class GetUsersSuccess {
  const GetUsersSuccess(this.users);

  final List<UserModel> users;
}

class GetUserProfilePending {
  GetUserProfilePending({required this.id});

  final String id;
}

class GetUserProfileSuccess {
  GetUserProfileSuccess({required this.user});

  final UserModel user;
}

class RegistrationUserPending {
  RegistrationUserPending({required this.user});

  final UserModel user;
}

class RegistrationUserSuccess {
  RegistrationUserSuccess({required this.user});

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
