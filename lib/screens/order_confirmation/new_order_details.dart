import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/widgets/order_details/order_details.dart';
import 'package:sample_shop/common/widgets/preloader/preloader.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class NewOrder extends StatelessWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: StoreConnector<AppState, CurrentOrderModel?>(
            converter: (store) => store.state.orders.currentOrder,
            builder: (context, order) => order == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: const Preloader())
                : OrderDetails(
                    order: order,
                  )),
      ),
    );
  }
}
