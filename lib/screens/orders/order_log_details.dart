// Dart imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/widgets/double_back_to_close/double_back_to_close.dart';
import 'package:sample_shop/common/widgets/order_details/order_details.dart';
import 'package:sample_shop/common/widgets/preloader/preloader.dart';

// Project imports:
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class OrderLogDetails extends StatelessWidget {
  const OrderLogDetails({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: StoreConnector<AppState, CurrentOrderModel?>(
            onInit: ((store) =>
                store.dispatch(GetCurrentOrderPending(orderId: orderId))),
            converter: ((store) => store.state.orders.currentOrder),
            builder: (context, order) => order == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: const Preloader())
                : OrderDetails(
                    order: order,
                  ),
          ),
        ));
  }
}
