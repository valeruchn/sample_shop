// Project imports:
import 'package:sample_shop/store/models/product.model.dart';

class GetProductsPending{}

class GetProductsSuccess {
  final List<ProductModel> products;
  GetProductsSuccess(this.products);
}
