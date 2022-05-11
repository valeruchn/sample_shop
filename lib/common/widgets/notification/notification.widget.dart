// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:sample_shop/store/models/notification/notification.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/widgets/snackbar/snackbar.dart';
import 'package:sample_shop/store/actions/notification.action.dart';

class _ViewModel {
  _ViewModel({required this.markAsHandled, required this.notification});

  final Function markAsHandled;
  final NotificationModel? notification;
}

class NotificationHandler extends StatelessWidget {
  const NotificationHandler({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel(
          notification: store.state.notification,
          markAsHandled: () => store.dispatch(HandleNotification())),
      builder: (context, notificationState) => child,
      onWillChange: (_ViewModel? oldState, _ViewModel newState) {
        // Проверяем если есть сообщение - выводим его
        if (newState.notification != null) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar(context, newState.notification!));
          // сбрасываем состояние сообщения
          newState.markAsHandled();
        }
      },
      // виджет можно перестроить только при изменении ViewModel
      distinct: true,
    );
  }
}
