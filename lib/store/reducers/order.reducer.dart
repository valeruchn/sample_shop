// Package imports:
import 'package:redux/redux.dart';
// Project imports:
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/models/order/order.model.dart';

final Reducer<OrderModel> ordersReducer =
    combineReducers<OrderModel>(<OrderModel Function(OrderModel, dynamic)>[
  TypedReducer<OrderModel, CreateOrderSuccess>(_createOrder),
      TypedReducer<OrderModel, GetOrdersSuccess>(_getUserOrders),
      TypedReducer<OrderModel, GetCurrentOrderSuccess>(_getCurrentOrder)
]);

OrderModel _createOrder(OrderModel order, CreateOrderSuccess action) {
  return OrderModel(currentOrder: action.order, ordersLog: order.ordersLog);
}

OrderModel _getUserOrders(OrderModel state, GetOrdersSuccess action) {
  // Не передаем currentOrder чтоб обнулить при открытии скрина с ордерами
  return OrderModel(ordersLog: action.ordersLog);
}

OrderModel _getCurrentOrder(OrderModel state, GetCurrentOrderSuccess action) {
  return OrderModel(currentOrder: action.currentOrder, ordersLog: state.ordersLog);
}
