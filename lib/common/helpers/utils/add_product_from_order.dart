// Project imports:
import 'package:sample_shop/common/localStorage/cart_local_storage_actions.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';
import 'package:sample_shop/store/models/order/create_order_dto.model.dart';

// use in order epics
Future<CreateOrderDtoModel> addProductsFromOrder(
    CreateOrderDtoModel order) async {
  try {
    List<CartQueryModel> products = await getProductsFromLocalStorage();
    return CreateOrderDtoModel(
        firstName: order.firstName,
        address: order.address,
        comment: order.comment,
        products: products);
  } catch (e) {
    print('error add product from order: $e');
  }
  return order;
}
