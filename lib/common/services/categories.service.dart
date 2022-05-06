// Package imports:
import 'package:dio/dio.dart';
import 'package:sample_shop/common/helpers/api/app_api.dart';

// Project imports:
import 'package:sample_shop/store/models/categories/category.model.dart';

Future<List<CategoryModel>> getCategories() async {
  try {
    final Response res = await api.dio.get('/categories');
    final List<dynamic> categories = res.data;
    return categories
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  } catch (e) {
    print('error get categories: $e');
  }
  return [];
}
