// Project imports:
import 'package:sample_shop/store/models/cart/cart_item.model.dart';

// Получение списка товаров
class GetCartPending {}

class GetCartSuccess {
  List<CartItemModel> cartItems;
  GetCartSuccess({required this.cartItems});
}

// Получение товара в корзину
class AddToCartPending {
  final String id;
  final int count;
  AddToCartPending({required this.id, required this.count});
}

class AddToCartSuccess {
  final String id;
  final int count;
  AddToCartSuccess({required this.id, required this.count});
}

// Удаление товара из корзины
class DeleteFromCartPending {
  final String id;
  DeleteFromCartPending({required this.id});
}

class DeleteFromCartSuccess {
  final String id;
  DeleteFromCartSuccess({required this.id});
}

// Уменьшение количества товара в корзине
class DecrementItemFromCartPending {
  final String id;
  DecrementItemFromCartPending({required this.id});
}

class DecrementItemFromCartSuccess {
  final String id;
  DecrementItemFromCartSuccess({required this.id});
}

// Очитска корзины
class ClearCart{}
