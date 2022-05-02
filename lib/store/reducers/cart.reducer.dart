// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/models/cart/cart.model.dart';

final Reducer<CartModel> cartReducer =
    combineReducers<CartModel>(<CartModel Function(CartModel, dynamic)>[
  TypedReducer<CartModel, GetCartSuccess>(_getCart),
]);

// Получить товары в корзине
CartModel _getCart(CartModel cart, GetCartSuccess action) {
  return action.cart;

  // final totalPrice = action.cartItems
  //     // умножаем количество товара на цену и создаем массив с суммами по каждому товару
  //     .map((el) => el.price * el.count)
  //     .toList()
  //     // слаживаем суммы в массиве
  //     .fold(0, (int p, int c) => p + c);
  // return CartModel(
  //     cartItems: action.cartItems,
  //     totalPrice: totalPrice);
}
