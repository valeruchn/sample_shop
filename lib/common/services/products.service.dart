// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/store/models/products/product.model.dart';

// Получение списка продуктов с фильтрами
Future<List<ProductModel>> getProducts(
    {String? category = 'all',
    String? subcategory = 'pfiladelfia',
    String? search = ''}) async {
  try {
    final Response<dynamic> res = await api.dio.get<dynamic>(
        '/products/get-products?category=$category&subcategory=$subcategory&search=$search');
    final List<dynamic> products = res.data as List<dynamic>;
    // print('products: $products');
    return products
        .map<ProductModel>((dynamic products) =>
            ProductModel.fromJson(products as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('error get products: $e');
  }
  return [];
}

// Получение списка избранного пользователя
Future<List<ProductModel>> getFavouritesProducts() async {
  try {
    final Response res = await api.dio.get('/products/favourites');
    final List<dynamic> products = res.data;
    return products
        .map<ProductModel>((dynamic products) =>
            ProductModel.fromJson(products as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('error get favourites products: $e');
  }
  return [];
}
