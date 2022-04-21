// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/models/cart/cart.model.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';

final Reducer<CartModel> cartReducer =
    combineReducers<CartModel>(<CartModel Function(CartModel, dynamic)>[
  TypedReducer<CartModel, GetCartSuccess>(_getCart),
  TypedReducer<CartModel, AddToCartSuccess>(_addToCart),
  TypedReducer<CartModel, DeleteFromCartSuccess>(_deleteFromCart),
  TypedReducer<CartModel, DecrementItemFromCartSuccess>(
      _decrementProductItemFromCart),
      TypedReducer<CartModel, ClearCart>(_clearCart)
]);

// Получить товарі в корзине
CartModel _getCart(CartModel cart, GetCartSuccess action) {
  final totalPrice = action.cartItems
      // умножаем количество товара на цену и создаем массив с суммами по каждому товару
      .map((el) => el.price * el.count)
      .toList()
      // слаживаем суммі в массиве
      .fold(0, (int p, int c) => p + c);
  return CartModel(
      cartQueryParams: cart.cartQueryParams,
      cartItems: action.cartItems,
      totalPrice: totalPrice);
}

// Добавить товар в корзину
CartModel _addToCart(CartModel cart, AddToCartSuccess action) {
  final isElemInCart = cart.cartQueryParams
      .where((item) => item.id == action.id)
      .toList();
  if (isElemInCart.isNotEmpty) {
    return CartModel(
        cartItems: cart.cartItems,
        cartQueryParams: cart.cartQueryParams
            .map((el) => el.id == action.id
                ? CartQueryModel(id: el.id, count: el.count + action.count)
                : el)
            .toList(),
        totalPrice: cart.totalPrice);
  }
  return CartModel(
      cartItems: cart.cartItems,
      cartQueryParams: [...cart.cartQueryParams, CartQueryModel(id: action.id, count: action.count)],
      totalPrice: cart.totalPrice);
}

// Удалить выбранный товар из корзины
CartModel _deleteFromCart(CartModel cart, DeleteFromCartSuccess action) {
  return CartModel(
      cartItems: cart.cartItems,
      cartQueryParams:
          cart.cartQueryParams.where((param) => param.id != action.id).toList(),
      totalPrice: cart.totalPrice);
}

// Уменьшить колличество выбранного товара в корзине
CartModel _decrementProductItemFromCart(
    CartModel cart, DecrementItemFromCartSuccess action) {
  final isElemInCart = cart.cartQueryParams
      .where((item) => item.id == action.id && item.count > 1)
      .toList();
  if (isElemInCart.isNotEmpty) {
    return CartModel(
        cartItems: cart.cartItems,
        cartQueryParams: cart.cartQueryParams
            .map((el) => el.id == action.id
                ? CartQueryModel(id: el.id, count: el.count - 1)
                : el)
            .toList(),
        totalPrice: cart.totalPrice);
  } else {
    return CartModel(
        cartItems: cart.cartItems,
        cartQueryParams: cart.cartQueryParams
            .where((param) => param.id != action.id)
            .toList(),
        totalPrice: cart.totalPrice);
  }
}

// Очистка корзины
CartModel _clearCart(CartModel cart, ClearCart action) {
  return CartModel(cartQueryParams: [], cartItems: [], totalPrice: 0);
}
