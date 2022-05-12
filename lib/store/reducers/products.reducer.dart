// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/models/products/products.model.dart';
import 'package:sample_shop/store/models/products/products_query.model.dart';

final Reducer<ProductsModel> productsReducer = combineReducers<
    ProductsModel>(<ProductsModel Function(ProductsModel, dynamic)>[
  TypedReducer<ProductsModel, GetProductsSuccess>(_getProducts),
  TypedReducer<ProductsModel, NextPageProductsPending>(_nextPageProducts),
  TypedReducer<ProductsModel, GetFavouriteProductsPending>(
      _getFavouriteProducts),
  TypedReducer<ProductsModel, ResetQueryFiltersPending>(_resetQueryFilters),
  TypedReducer<ProductsModel, HandleSearchQueryPending>(_searchProducts),
  TypedReducer<ProductsModel, SelectProductCategoryPending>(_selectCategory),
  TypedReducer<ProductsModel, LastPageProductPending>(_lastPageProducts),
]);

// Добавление продуктов в хранилище
ProductsModel _getProducts(ProductsModel state, GetProductsSuccess action) {
  return ProductsModel(
      // Если это не стартовая страница - добавляем продукты к массиву
      productsList: state.productsQuery.page > 1
          ? [...state.productsList, ...action.products]
          : action.products,
      productsQuery: state.productsQuery);
}

// Переключение страницы
ProductsModel _nextPageProducts(
    ProductsModel state, NextPageProductsPending action) {
  if (state.productsQuery.isLastPage) {
    return state;
  } else {
    return ProductsModel(
        productsList: state.productsList,
        productsQuery: ProductQueryModel(
            category: state.productsQuery.category,
            subcategory: state.productsQuery.subcategory,
            search: state.productsQuery.search,
            isLoad: state.productsQuery.isLoad,
            page: state.productsQuery.page + 1,
            favourites: state.productsQuery.favourites));
  }
}

// Отметить что последняя страница
ProductsModel _lastPageProducts(
    ProductsModel state, LastPageProductPending action) {
  return ProductsModel(
      productsList: state.productsList,
      productsQuery: ProductQueryModel(
          category: state.productsQuery.category,
          subcategory: state.productsQuery.subcategory,
          search: state.productsQuery.search,
          isLoad: state.productsQuery.isLoad,
          page: state.productsQuery.page,
          favourites: state.productsQuery.favourites,
          isLastPage: true));
}

// Выборка фаворитов
ProductsModel _getFavouriteProducts(
    ProductsModel state, GetFavouriteProductsPending action) {
  return ProductsModel(
      productsList: state.productsList,
      productsQuery: const ProductQueryModel(favourites: true));
}

// Сброс поисковіх фильтров
ProductsModel _resetQueryFilters(
    ProductsModel state, ResetQueryFiltersPending action) {
  return ProductsModel(
      productsList: state.productsList,
      productsQuery: const ProductQueryModel());
}

// Поиск по названию (ввод пользователя)
ProductsModel _searchProducts(
    ProductsModel state, HandleSearchQueryPending action) {
  return ProductsModel(
      productsList: state.productsList,
      productsQuery: ProductQueryModel(search: action.search));
}

// Поиск товара по категории
ProductsModel _selectCategory(
    ProductsModel state, SelectProductCategoryPending action) {
  return ProductsModel(
      productsList: state.productsList,
      productsQuery: ProductQueryModel(
          category: action.category, subcategory: action.subcategory));
}
