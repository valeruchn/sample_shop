// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/store.dart';

class _FilterModel extends Equatable {
  const _FilterModel(
      {this.page = 1, this.isLastPage = false, this.startDate, this.endDate});

  final int page;
  final bool isLastPage;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  List<Object?> get props => [page, isLastPage, startDate, endDate];
}

class OrdersLogFiltersListener extends StatelessWidget {
  const OrdersLogFiltersListener({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _FilterModel>(
      // Если продукты ранее не были загружены - запрашиваем
      onInit: (store) {
        final _phone = store.state.user.phone;
        if (_phone != '') {
          store.dispatch(GetOrdersPending());
        }
      },
      converter: (store) {
        final query = store.state.orders.ordersQuery;
        return _FilterModel(
            startDate: query.startDate,
            endDate: query.endDate,
            page: query.page,
            isLastPage: query.isLastPage);
      },
      builder: (context, state) => child,
      onWillChange: (oldState, newState) {
        // Если параметры запроса в стейте изменились
        // и еще доступны ордера к загрузке - делаем запрос
        if (oldState != newState && !newState.isLastPage) {
          store.dispatch(GetOrdersPending());
        }
      },
      // виджет можно перестроить только при изменении ViewModel
      distinct: true,
    );
  }
}
