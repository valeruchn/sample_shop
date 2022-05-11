// Project imports:
import 'package:sample_shop/store/models/products/product.model.dart';

class GetProductsPending {
  GetProductsPending({this.category, this.search, this.subcategory});

  final String? category;
  final String? subcategory;
  final String? search;
}

class GetProductsSuccess {
  GetProductsSuccess(this.products);

  final List<ProductModel> products;
}

// Получение продукта по id
class GetProductPending{
  GetProductPending({ required this.productId });
  final String productId;
}

class GetProductSuccess{
  GetProductSuccess({required this.product});
  ProductModel product;
}

// Получить список избранных продуктов
class GetFavouriteProductsPending {}

class GetFavouriteProductsSuccess {
  GetFavouriteProductsSuccess({required this.products});

  final List<ProductModel> products;
}
