// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/store/actions/notification.action.dart';
import 'package:sample_shop/store/models/notification/notification.model.dart';
import 'package:sample_shop/store/models/products/product.model.dart';
import 'package:sample_shop/store/store.dart';

// Получение списка продуктов с фильтрами
Future<List<ProductModel>> getProducts(
    {String? category = 'all',
    String? subcategory = '',
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

// Получение продукта по id
Future<ProductModel?> getProduct(String productId) async{
  try {
    final Response res = await api.dio.get('/products/get-products/$productId');
    final Map<String, dynamic> product = res.data;
    return ProductModel.fromJson(product);
  } catch (e) {
    print('error get product: $e');
  }
  return null;
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
