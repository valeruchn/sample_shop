// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sample_shop/common/services/order.service.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';

Stream<void> createOrderEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is CreateOrderPending)
      .switchMap((dynamic action) =>
          Stream<CurrentOrderModel>.fromFuture(addOrder(action.order))
              .expand<dynamic>((CurrentOrderModel order) =>
                  <dynamic>[CreateOrderSuccess(order: order), ClearCart()])
              .handleError((dynamic e) => {print(e)}));
}
