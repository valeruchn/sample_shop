// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/models/categories/category.model.dart';
import 'package:sample_shop/store/models/products/product.model.dart';
import 'package:sample_shop/store/actions/home_page_title.action.dart';
import 'package:sample_shop/common/helpers/utils/get_category_title.dart';
import 'package:sample_shop/common/services/products.service.dart';

Stream<void> getProductsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetProductsPending)
      .switchMap((dynamic action) => Stream<List<ProductModel>>.fromFuture(
              getProducts(
                  category: action?.category ?? '',
                  subcategory: action?.subcategory ?? '',
                  search: action?.search ?? ''))
          .expand<dynamic>((List<ProductModel> products) => <dynamic>[
                GetProductsSuccess(products),
                // Заголовок домашней страницы
                SetHomePageTitleSuccess(
                  search: action?.search,
                  category: getCategoryTitle(
                      categories: store.state.categories as List<CategoryModel>,
                      category: action?.category,
                      subcategory: action?.subcategory),
                )
              ])
          .handleError((dynamic e) => {print(e)}));
}

Stream<void> getProductEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((action) => action is GetProductPending).switchMap(
      (action) => Stream<ProductModel?>.fromFuture(getProduct(action.productId))
          .expand((ProductModel? product) =>
              [if (product != null) GetProductSuccess(product: product)])
          .handleError((e) => {print('error get product epic: $e')}));
}

Stream<void> getFavouriteProductsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is GetFavouriteProductsPending)
      .switchMap((action) =>
          Stream<List<ProductModel>>.fromFuture(getFavouritesProducts())
              .expand((List<ProductModel> products) => [
                    GetFavouriteProductsSuccess(products: products),
                    SetHomePageTitleSuccess(favourites: true)
                  ])
              .handleError(
                  (e) => {print('error get favourite products epic: $e')}));
}
