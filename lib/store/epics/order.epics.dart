// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sample_shop/common/services/order.service.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/actions/notification.action.dart';
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/helpers/utils/add_product_from_order.dart';
import 'package:sample_shop/store/models/notification/notification.model.dart';
import 'package:sample_shop/store/models/order/create_order_dto.model.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';

Stream<void> createOrderEpic(
    Stream<dynamic> actions, EpicStore<dynamic> epicStore) {
  return actions
      .where((dynamic action) => action is CreateOrderPending)
      .switchMap((dynamic action) =>
          // получаем товары из корзины и добавляем в CreateOrderDtoModel
          Stream<CreateOrderDtoModel>.fromFuture(
              addProductsFromOrder(action.order)))
      .switchMap((CreateOrderDtoModel preparedOrder) =>
          // Добавляем заказ на api
          Stream<CurrentOrderModel>.fromFuture(createNewOrder(preparedOrder)))
      .switchMap((CurrentOrderModel order) =>
          // Добавляем заказ в firestore
          Stream<CurrentOrderModel>.fromFuture(addOrder(order))
              .expand<dynamic>((CurrentOrderModel order) =>
                  // Добавляем заказ в state
                  <dynamic>[
                    CreateOrderSuccess(order: order),
                    // Показваем уведомление что заказ создан
                    IsNotification(
                        notification: NotificationModel(
                            type: NotificationType.success,
                            message: kNewOrderCreatedSuccessText)),
                    ClearCart()
                  ])
              .handleError((dynamic e) {
            print('create order epic error: $e');
          }));
}

Stream<void> getUserOrdersEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is GetOrdersPending)
      .switchMap((action) =>
          Stream<List<CurrentOrderModel>>.fromFuture(getOrdersLog()))
      .expand((List<CurrentOrderModel> orders) =>
          [GetOrdersSuccess(ordersLog: orders)])
      .handleError((dynamic e) => {print(e)});
}

Stream<void> getCurrentOrderEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is GetCurrentOrderPending)
      .switchMap((action) =>
          Stream<CurrentOrderModel>.fromFuture(getCurrentOrder(action.orderId)))
      .expand((CurrentOrderModel order) =>
          [GetCurrentOrderSuccess(currentOrder: order)])
      .handleError((e) => print(e));
}
