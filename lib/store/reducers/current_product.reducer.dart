// Flutter imports:
import 'package:redux/redux.dart';
// Project imports:
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/models/products/product.model.dart';

Reducer<ProductModel?> currentProductReducer = combineReducers<
    ProductModel?>(<ProductModel? Function(ProductModel?, dynamic)>[
  TypedReducer<ProductModel?, GetProductSuccess>(_getCurrentProduct),
]);

ProductModel? _getCurrentProduct(ProductModel? state, GetProductSuccess action) {
  return action.product;
}
