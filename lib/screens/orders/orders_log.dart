// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/widgets/orders_log/orders_log_filters_listener.widget.dart';

// Project imports:
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/screens/orders/orders_log_item.dart';
import 'package:sample_shop/store/store.dart';

class _OrderStateModel {
  _OrderStateModel({required this.orders, required this.isLoad});

  List<CurrentOrderModel> orders;
  final bool isLoad;
}

class OrdersLog extends StatefulWidget {
  const OrdersLog({Key? key}) : super(key: key);

  @override
  State<OrdersLog> createState() => _OrdersLogState();
}

class _OrdersLogState extends State<OrdersLog> {
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    // когда позиция скрола достигла последнего елемента
    // происходит запрос следующей страницы
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      store.dispatch(NextPageOrdersPending());
    }
  }

  // Подписываемся на отслеживание скрола
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  // Отписываемся при размонтировании виджета
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrdersLogFiltersListener(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(kOrdersLogTitleText),
        ),
        body: StoreConnector<AppState, _OrderStateModel>(
          converter: (store) => _OrderStateModel(
              orders: store.state.orders.ordersLog,
              isLoad: store.state.orders.ordersQuery.isLoading),
          builder: (context, ordersState) => Container(
            color: kBackGroundColor,
            // width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      ...ordersState.orders
                          .map((order) => OrdersLogItem(order: order))
                          .toList(),
                    ],
                  ),
                ),
                if (ordersState.isLoad) const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
