// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';

Future<List<CartItemModel>> getCartItems(List<CartQueryModel> cart) async {
  try {
    final Response<dynamic> res = await api
        // в параметрах конвертируем запрос в json
        .post<dynamic>('/products/cart',
            data: <String, dynamic>{'payload': cart});
    final List<dynamic> cartItems = res.data as List<dynamic>;
    return cartItems
        .map<CartItemModel>((dynamic cartItems) =>
            CartItemModel.fromJson(cartItems as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('error: $e');
  }
  return [];
}
