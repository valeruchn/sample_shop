import 'package:sample_shop/store/models/order/create_order_dto.model.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';

class CreateOrderPending{
  CreateOrderPending({required this.order});
  final CreateOrderDtoModel order;
}

class CreateOrderSuccess{
  CreateOrderSuccess({required this.order});
  final CurrentOrderModel order;
}