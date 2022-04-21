// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/store/models/product.model.dart';

Future<List<ProductModel>> getProducts() async {
  try {
    final Response<dynamic> res =
        await api.get<dynamic>('/products/get-products');
    final List<dynamic> products = res.data as List<dynamic>;
    // print('products: $products');
    return products
        .map<ProductModel>((dynamic products) =>
            ProductModel.fromJson(products as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('error: $e');
  }
  return [];
}
