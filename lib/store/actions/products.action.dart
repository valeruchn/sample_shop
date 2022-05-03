// Project imports:
import 'package:sample_shop/store/models/products/product.model.dart';

class GetProductsPending {
  GetProductsPending({this.category, this.search});

  final String? category;
  final String? search;
}

class GetProductsSuccess {
  GetProductsSuccess(this.products);

  final List<ProductModel> products;
}
