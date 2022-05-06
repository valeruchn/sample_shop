// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// import 'package:sample_shop/common/helpers/mocks/products_data.dart';
import 'package:sample_shop/common/services/products.service.dart';

// Project imports:
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/models/products/product.model.dart';

Stream<void> getProductsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetProductsPending)
      .switchMap((dynamic action) => Stream<List<ProductModel>>.fromFuture(
              getProducts(
                  category: action?.category ?? '',
                  subcategory: action?.subcategory ?? '',
                  search: action?.search ?? '')
              // Future.delayed(const Duration(milliseconds: 500),
              //     () => ProductsData().products)
              )
          .expand<dynamic>((List<ProductModel> products) =>
              <dynamic>[GetProductsSuccess(products)])
          .handleError((dynamic e) => {print(e)}));
}

Stream<void> getFavouriteProductsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is GetFavouriteProductsPending)
      .switchMap((action) =>
          Stream<List<ProductModel>>.fromFuture(getFavouritesProducts())
              .expand(
                  (List<ProductModel> products) =>
                      [GetFavouriteProductsSuccess(products: products)])
              .handleError(
                  (e) => {print('error get favourite products epic: $e')}));
}
