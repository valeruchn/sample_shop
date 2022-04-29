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

// todo добавить jwt token, брать телефон из токена
class GetOrdersPending {
  GetOrdersPending({required this.phone});

  final String phone;
}

class GetOrdersSuccess {
  GetOrdersSuccess({required this.ordersLog});

  final List<CurrentOrderModel> ordersLog;
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
