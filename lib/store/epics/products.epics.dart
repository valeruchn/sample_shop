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
import 'package:sample_shop/store/models/products/products_query.model.dart';

ProductQueryModel _query(EpicStore<dynamic> store) =>
    store.state.products.productsQuery;

Stream<void> getProductsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetProductsPending)
      .switchMap((dynamic action) => Stream<List<ProductModel>>.fromFuture(
              store.state.products.productsQuery.favourites
                  ? getFavouritesProducts(page: _query(store).page)
                  : getProducts(
                      category: _query(store).category ?? '',
                      subcategory: _query(store).subcategory ?? '',
                      search: _query(store).search ?? '',
                      page: _query(store).page))
          .expand<dynamic>((List<ProductModel> products) => <dynamic>[
                GetProductsSuccess(products),
                // Заголовок домашней страницы
                SetHomePageTitleSuccess(
                  favourites: _query(store).favourites,
                  search: _query(store).search,
                  category: getCategoryTitle(
                      categories: store.state.categories as List<CategoryModel>,
                      category: _query(store).category,
                      subcategory: _query(store).subcategory),
                ),
                if (products.isEmpty) LastPageProductPending()
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
