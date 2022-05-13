// Project imports:
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/models/order/orders_query.model.dart';

class OrderModel {
  OrderModel(
      {this.currentOrder,
      this.ordersLog = const [],
      required this.ordersQuery});

  OrdersQueryModel ordersQuery;
  CurrentOrderModel? currentOrder;
  List<CurrentOrderModel> ordersLog;
}
