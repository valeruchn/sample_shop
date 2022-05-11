// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/common/helpers/utils/conver_order_status.dart';

// Project imports:
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/store/actions/order.action.dart';

class OrdersLog extends StatelessWidget {
  const OrdersLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<CurrentOrderModel>>(
        onInit: (store) {
          final _phone = store.state.user.phone;
          if (_phone != '') {
            store.dispatch(GetOrdersPending());
          }
        },
        converter: (store) => store.state.orders.ordersLog ?? [],
        builder: (context, orders) => Scaffold(
              appBar: AppBar(
                title: const Text(kOrdersLogTitleText),
              ),
              body: Container(
                color: kBackGroundColor,
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    ...orders
                        .map((order) => InkWell(
                              // Переход в подробности заказа
                              onTap: () => Routemaster.of(context)
                                  .push('/order/${order.id}'),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.00),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: kItemBackgroundColor,
                                    // border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.black,
                                          offset: Offset(1, 3))
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 4,
                                          fit: FlexFit.tight,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Замовлення: ${order.oid}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  'від: ${DateFormat('yyyy-MM-dd').format(order.date)}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  'Cтатус: ${convertOrderStatus(order.status)}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                    'Сумма: ${order.totalPrice} грн',
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          'Склад: ${order.products.map((p) => p.title).join(', ')}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList()
                  ],
                ),
              ),
            ));
  }
}
