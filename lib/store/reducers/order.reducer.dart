// Package imports:
import 'package:redux/redux.dart';
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/models/order/order.model.dart';

final Reducer<OrderModel> ordersReducer =
    combineReducers<OrderModel>(<OrderModel Function(OrderModel, dynamic)>[
  TypedReducer<OrderModel, CreateOrderSuccess>(_createOrder)
]);

OrderModel _createOrder(OrderModel order, CreateOrderSuccess action) {
  return OrderModel(currentOrder: action.order, ordersLog: order.ordersLog);
}
