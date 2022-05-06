// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/store/models/cart/cart.model.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';

Future<CartModel> getCartItems(List<CartQueryModel> cart) async {
  try {
    final Response res = await api.dio
        // в параметрах конвертируем запрос в json
        .post('/products/cart', data: <String, dynamic>{'payload': cart});
    final Map<String, dynamic> result = res.data;
    return CartModel.fromJson(result);
  } catch (e) {
    print('error get cart: $e');
  }
  return CartModel(cartItems: [], totalPrice: 0);
}
