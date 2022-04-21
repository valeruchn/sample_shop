// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sample_shop/common/services/cart.service.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

Stream<void> getCartEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  // switchMap преобразует елемент в поток, вновь созданный поток прослушивает последнюю версию
  return actions.where((dynamic action) => action is GetCartPending).switchMap(
      (dynamic action) => Stream<List<CartItemModel>>.fromFuture(
              getCartItems(store.state.cart.cartQueryParams))
          .expand<dynamic>((List<CartItemModel> cartItems) =>
              <dynamic>[GetCartSuccess(cartItems: cartItems)])
          .handleError((dynamic e) => {print('error: $e')}));
}

// Добавление товара в корзину
Stream<void> addToCartEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is AddToCartPending)
      // Stream value возвращает поток в котором выполняет действие один раз
      .switchMap((action) => Stream.value(action)
          // преобразует каждый елемент потока в последовательность елементов
          .expand((action) => <dynamic>[
                // обновляем список для запроса корзины
                AddToCartSuccess(id: action.id, count: action.count),
                // запрашиваем корзину
                GetCartPending()
              ])
          .handleError((dynamic e) => {print('error: $e')}));
}

// Удаление товара из корзины
Stream<void> deleteFromCartEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is DeleteFromCartPending)
      // Stream value возвращает поток в котором выполняет действие один раз
      // switchMap преобразует каждый елемент массива Stream в поток, при етом прослушивается вновь созданный 
      // поток, ранее созданые не прослушиваются
      .switchMap((action) => Stream.value(action)
          // преобразует каждый елемент потока в последовательность елементов
          .expand((action) => <dynamic>[
                // обновляем список для запроса корзины
                DeleteFromCartSuccess(id: action.id),
                // запрашиваем корзину
                GetCartPending()
              ])
          .handleError((dynamic e) => {print('error: $e')}));
}

// Уменьшение колличества товаров в корзине
Stream<void> decrementItemFromCartEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is DecrementItemFromCartPending)
      // Stream value возвращает поток в котором выполняет действие один раз
      // switchMap преобразует каждый елемент массива Stream в поток, при етом прослушивается вновь созданный 
      // поток, ранее созданые не прослушиваются
      .switchMap((action) => Stream.value(action)
          // преобразует каждый елемент потока в последовательность елементов
          .expand((action) => <dynamic>[
                // обновляем список для запроса корзины
                DecrementItemFromCartSuccess(id: action.id),
                // запрашиваем корзину
                GetCartPending()
              ])
          .handleError((dynamic e) => {print('error: $e')}));
}
