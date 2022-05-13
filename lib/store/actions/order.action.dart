import 'package:sample_shop/store/models/order/create_order_dto.model.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';

class CreateOrderPending {
  CreateOrderPending({required this.order});

  final CreateOrderDtoModel order;
}

class CreateOrderSuccess {
  CreateOrderSuccess({required this.order});

  final CurrentOrderModel order;
}

// получение ордера по id
class GetCurrentOrderPending {
  GetCurrentOrderPending({required this.orderId});

  final String orderId;
}

class GetCurrentOrderSuccess {
  GetCurrentOrderSuccess({required this.currentOrder});

  final CurrentOrderModel currentOrder;
}

class GetOrdersPending {}

class GetOrdersSuccess {
  GetOrdersSuccess({required this.ordersLog});

  final List<CurrentOrderModel> ordersLog;
}

class NextPageOrdersPending {}

class LastPageOrderPending {}

class ResetQueryFiltersPending {}
