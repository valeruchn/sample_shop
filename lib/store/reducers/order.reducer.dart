// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/models/order/order.model.dart';
import 'package:sample_shop/store/models/order/orders_query.model.dart';

final Reducer<OrderModel> ordersReducer =
    combineReducers<OrderModel>(<OrderModel Function(OrderModel, dynamic)>[
  TypedReducer<OrderModel, CreateOrderSuccess>(_createOrder),
  TypedReducer<OrderModel, GetOrdersSuccess>(_getUserOrders),
  TypedReducer<OrderModel, GetCurrentOrderSuccess>(_getCurrentOrder),
  TypedReducer<OrderModel, NextPageOrdersPending>(_nextPageOrder),
  TypedReducer<OrderModel, LastPageOrderPending>(_lastPageOrder),
  TypedReducer<OrderModel, ResetQueryFiltersPending>(_resetOrderQuery)
]);

OrderModel _createOrder(OrderModel state, CreateOrderSuccess action) {
  return OrderModel(
      currentOrder: action.order,
      ordersLog: [action.order, ...state.ordersLog],
      ordersQuery: state.ordersQuery);
}

OrderModel _getUserOrders(OrderModel state, GetOrdersSuccess action) {
  // Не передаем currentOrder чтоб обнулить при открытии скрина с ордерами
  return OrderModel(
      ordersLog: state.ordersLog.isNotEmpty
          ? [...state.ordersLog, ...action.ordersLog]
          : action.ordersLog,
      ordersQuery: OrdersQueryModel(
        page: state.ordersQuery.page,
        isLastPage: state.ordersQuery.isLastPage,
        isLoading: false,
        startDate: state.ordersQuery.startDate,
        endDate: state.ordersQuery.endDate,
      ));
}

OrderModel _getCurrentOrder(OrderModel state, GetCurrentOrderSuccess action) {
  return OrderModel(
      currentOrder: action.currentOrder,
      ordersLog: state.ordersLog,
      ordersQuery: state.ordersQuery);
}

OrderModel _nextPageOrder(OrderModel state, NextPageOrdersPending action) {
  if (state.ordersQuery.isLastPage ||
      state.ordersQuery.isLoading) {
    return state;
  } else {
    return OrderModel(
        ordersLog: state.ordersLog,
        ordersQuery: OrdersQueryModel(
          page: state.ordersQuery.page + 1,
          isLastPage: state.ordersQuery.isLastPage,
          isLoading: true,
          startDate: state.ordersQuery.startDate,
          endDate: state.ordersQuery.endDate,
        ));
  }
}

OrderModel _lastPageOrder(OrderModel state, LastPageOrderPending action) {
  return OrderModel(
      ordersLog: state.ordersLog,
      ordersQuery: OrdersQueryModel(
        page: state.ordersQuery.page,
        isLastPage: true,
        isLoading: state.ordersQuery.isLoading,
        startDate: state.ordersQuery.startDate,
        endDate: state.ordersQuery.endDate,
      ));
}

OrderModel _resetOrderQuery(OrderModel state, ResetQueryFiltersPending action) {
  return OrderModel(
      ordersLog: state.ordersLog,
      currentOrder: state.currentOrder,
      ordersQuery: OrdersQueryModel());
}
