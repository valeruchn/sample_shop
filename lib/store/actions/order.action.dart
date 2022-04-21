import 'package:sample_shop/store/models/order/current_order.model.dart';

class CreateOrderPending{
  CreateOrderPending({required this.order});
  final CurrentOrderModel order;
}

class CreateOrderSuccess{
  CreateOrderSuccess({required this.order});
  final CurrentOrderModel order;
}