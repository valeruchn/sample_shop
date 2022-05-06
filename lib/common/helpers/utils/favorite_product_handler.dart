import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

FavouriteProductHandler favouriteProductHandler = FavouriteProductHandler();

class FavouriteProductHandler {
  // Добавление удаление товара из фаворитов
  Map<String, dynamic> useHandler(
      Store<AppState> store, String id) {
    List<String> favourites = store.state.user.favorits ?? [];
    bool isFavourite = _isFavourite(favourites, id);
    void action() {
      if (isFavourite) {
        store.dispatch(DeleteProductFromFavouritesPending(id: id));
      } else {
        store.dispatch(AddProductToFavoritePending(id: id));
      }
    }

    return {'isFavourite': isFavourite, 'action': action};
  }

  // Вывод иконки фаворит
  FaIcon favouriteIcon(bool isFavourite) {
    if (isFavourite) {
      return const FaIcon(
        FontAwesomeIcons.solidHeart,
        color: kFavouriteIconColor,
      );
    } else {
      return const FaIcon(
        FontAwesomeIcons.heart,
        color: kFavouriteIconColor,
      );
    }
  }

  // Проверка что товар в фаворитах
  bool _isFavourite(List<String> favourites, String productId) {
    if (favourites.contains(productId)) {
      return true;
    } else {
      return false;
    }
  }
}
