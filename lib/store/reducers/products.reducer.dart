// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/store/models/products/product.model.dart';
import 'package:sample_shop/store/actions/products.action.dart';

final Reducer<List<ProductModel>> productsReducer = combineReducers<
    List<ProductModel>>(
    <List<ProductModel> Function(List<ProductModel>, dynamic)>[
      TypedReducer<List<ProductModel>, GetProductsSuccess>(_getProducts),
      TypedReducer<List<ProductModel>, GetFavouriteProductsSuccess>(
          _getFavouriteProducts)
    ]);

List<ProductModel> _getProducts(List<ProductModel> products,
    GetProductsSuccess action) {
  return action.products;
}

List<ProductModel> _getFavouriteProducts(List<ProductModel> products,
    GetFavouriteProductsSuccess action) {
  return action.products;
}