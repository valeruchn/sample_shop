import 'package:sample_shop/store/models/products/product.model.dart';
import 'package:sample_shop/store/models/products/products_query.model.dart';

class ProductsModel {
  ProductsModel({required this.productsList, required this.productsQuery});

  ProductQueryModel productsQuery;
  List<ProductModel> productsList;
}
