// Project imports:
import 'package:sample_shop/store/models/products/product.model.dart';

class GetProductsPending {}

class GetProductsSuccess {
  GetProductsSuccess(this.products);

  final List<ProductModel> products;
}

// Получение продукта по id
class GetProductPending {
  GetProductPending({required this.productId});

  final String productId;
}

class GetProductSuccess {
  GetProductSuccess({required this.product});

  ProductModel product;
}

// Получить список избранных продуктов
class GetFavouriteProductsPending {}

// Сбросить фильтры поиска
class ResetQueryFiltersPending {}

// Поиск по названию (ввод пользователя)
class HandleSearchQueryPending {
  HandleSearchQueryPending({required this.search});

  String search;
}

// Фильтр по категории
class SelectProductCategoryPending {
  SelectProductCategoryPending({required this.category, this.subcategory});

  final String category;
  final String? subcategory;
}

// Переключить на следующую страницу
class NextPageProductsPending {}

// Отметить что последняя страница
class LastPageProductPending {}
