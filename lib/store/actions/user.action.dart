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

class AddProductToFavoritePending{
  AddProductToFavoritePending({required this.id});
  final String id;
}

class AddProductToFavoriteSuccess{
  AddProductToFavoriteSuccess({required this.favorits});
  List<String> favorits;
}

class DeleteProductFromFavouritesPending{
  DeleteProductFromFavouritesPending({required this.id});
  final String id;
}

class DeleteProductFromFavouritesSuccess{
  DeleteProductFromFavouritesSuccess({required this.favorits});
  List<String> favorits;
}

// class GetUsersPending {}
//
// class GetUsersSuccess {
//   const GetUsersSuccess(this.users);
//
//   final List<UserModel> users;
// }
