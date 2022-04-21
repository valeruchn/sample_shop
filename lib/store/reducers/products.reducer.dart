// Package imports:
import 'package:redux/redux.dart';
// Project imports:
import 'package:sample_shop/store/models/product.model.dart';
import 'package:sample_shop/store/actions/products.action.dart';

final Reducer<List<ProductModel>> productsReducer = combineReducers<
    List<ProductModel>>(<List<ProductModel> Function(List<ProductModel>, dynamic)>[
  TypedReducer<List<ProductModel>, GetProductsSuccess>(_getProducts)
]);

List<ProductModel> _getProducts(
    List<ProductModel> products, GetProductsSuccess action) {
  return action.products;
}