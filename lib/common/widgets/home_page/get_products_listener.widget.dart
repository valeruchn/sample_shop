// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/store.dart';

// используем пакет equatable для сравнения обьектов
class _FilterModel extends Equatable {
  const _FilterModel(
      {this.category,
      this.subcategory,
      this.search,
      this.favourites = false,
      this.page = 1,
      this.isLoad = false,
      this.isLastPage = false});

  final String? category;
  final String? subcategory;
  final String? search;
  final bool isLoad;
  final int page;
  final bool favourites;
  final bool isLastPage;

  @override
  List<Object?> get props =>
      [page, isLoad, favourites, search, subcategory, category];
}

class GetProductsListener extends StatelessWidget {
  const GetProductsListener({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _FilterModel>(
      // Если продукты ранее не были загружены - запрашиваем
      onInit: (store) {
        if (store.state.products.productsList.isEmpty) {
          store.dispatch(GetProductsPending());
        }
        // Запрос корзины
        store.dispatch(GetCartPending());
      },
      converter: (store) {
        final query = store.state.products.productsQuery;
        return _FilterModel(
            category: query.category,
            subcategory: query.subcategory,
            search: query.search,
            isLoad: query.isLoad,
            page: query.page,
            favourites: query.favourites);
      },
      builder: (context, state) => child,
      // Если параметры запроса в стейте изменились - запрашиваем продукты
      onWillChange: (oldState, newState) {
        if (oldState != newState && !newState.isLastPage) {
          print(newState.page);
          store.dispatch(GetProductsPending());
        }
      },
      // виджет можно перестроить только при изменении ViewModel
      distinct: true,
    );
  }
}
