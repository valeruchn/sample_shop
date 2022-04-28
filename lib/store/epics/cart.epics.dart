// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sample_shop/common/localStorage/cart_local_storage_actions.dart';

// Project imports:
import 'package:sample_shop/common/services/cart.service.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

Stream<void> getCartEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  // switchMap преобразует елемент в поток, вновь созданный поток прослушивает последнюю версию
  return actions
      .where((dynamic action) => action is GetCartPending)
      .switchMap((dynamic action) => Stream<List<CartQueryModel>>.fromFuture(
          getProductsFromLocalStorage()))
      .switchMap((List<CartQueryModel> query) =>
          Stream<List<CartItemModel>>.fromFuture(getCartItems(query))
              .expand<dynamic>((List<CartItemModel> cartItems) =>
                  <dynamic>[GetCartSuccess(cartItems: cartItems)])
              .handleError((dynamic e) => {print('error: $e')}));
}

// Добавление товара в корзину
Stream<void> addToCartEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is AddToCartPending)
      .switchMap((action) => Stream.fromFuture(
              // Добавляем елемент в локальное хранилище
              addCartItemsInAsyncStorage(
                  CartQueryModel(id: action.id, count: action.count)))
          // преобразует каждый елемент потока в последовательность елементов
          .expand((value) => <dynamic>[
                // Запрашиваем продукты с api по id из корзины
                GetCartPending()
              ])
          .handleError((dynamic e) => {print('error: $e')}));
}

// Удаление товара из корзины
Stream<void> deleteFromCartEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is DeleteFromCartPending)
      // удаляем елемент в локальном хранилище
      .switchMap((action) => Stream.fromFuture(
              deleteItemFromCartInAsyncStorage(action.id))
          // преобразует каждый елемент потока в последовательность елементов
          .expand((value) => <dynamic>[
                // запрашиваем корзину
                GetCartPending()
              ])
          .handleError((dynamic e) => {print('error: $e')}));
}

// Уменьшение колличества товаров в корзине
Stream<void> decrementItemFromCartEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is DecrementItemFromCartPending)
      // уменьшаем количество елементов в корзине в локальном хранилище
      .switchMap((action) => Stream.fromFuture(
              decrementCartItemsInAsyncStorage(action.id))
          // преобразует каждый елемент потока в последовательность елементов
          .expand((value) => <dynamic>[
                // запрашиваем корзину
                GetCartPending()
              ])
          .handleError((dynamic e) => {print('error: $e')}));
}

//Очистка корзины
Stream<void> clearCartEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((action) => action is ClearCart).switchMap((action) =>
      // Очищаем корзину в локальном хранилище
      Stream.fromFuture(clearCartFromAsyncStorage())
          // Запрашиваем корзину
          .expand((value) => <dynamic>[GetCartPending()])
          .handleError((dynamic e) => {print('error: $e')}));
}
