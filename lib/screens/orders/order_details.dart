// Dart imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StoreConnector<AppState, CurrentOrderModel?>(
          onInit: ((store) =>
              store.dispatch(GetCurrentOrderPending(orderId: orderId))),
          converter: ((store) => store.state.orders.currentOrder),
          builder: (context, currentOrder) => Center(
              child: Column(
            children: [
              Text(orderId),
              if (currentOrder != null) Text(currentOrder.status)
            ],
          )),
        ));
  }
}
