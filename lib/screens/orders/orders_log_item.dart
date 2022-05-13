// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

// Project imports:
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/utils/conver_order_status.dart';

class OrdersLogItem extends StatelessWidget {
  const OrdersLogItem({Key? key, required this.order}) : super(key: key);
  final CurrentOrderModel order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Переход в подробности заказа
      onTap: () => Routemaster.of(context).push('/order/${order.id}'),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.00),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: kItemBackgroundColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$kOrderNumberTitleText: ${order.oid}'),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Text(
                            '$kStartOrderTitleText: ${DateFormat('yyyy-MM-dd').format(order.date)}'),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          '$kOrderStatusText: ${convertOrderStatus(order.status)}'),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Text(
                            '$kOrderSumText: ${order.totalPrice} $kCurrencyUah'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: kDefaultLabelTextColor,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                  '$kOrderListText: ${order.products.map((p) => p.title).join(', ')}'),
            ),
          ],
        ),
      ),
    );
  }
}
