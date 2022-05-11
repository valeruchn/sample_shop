import 'package:redux/redux.dart';
import 'package:sample_shop/store/actions/notification.action.dart';
import 'package:sample_shop/store/models/notification/notification.model.dart';

Reducer<NotificationModel?> notificationReducer =
    combineReducers<NotificationModel?>(<
        NotificationModel? Function(NotificationModel?, dynamic)>[
  TypedReducer<NotificationModel?, IsNotification>(_createNotification),
  TypedReducer<NotificationModel?, HandleNotification>(_handleNotification),
]);

NotificationModel? _createNotification(
    NotificationModel? state, IsNotification action) {
  return action.notification;
}

NotificationModel? _handleNotification(
    NotificationModel? state, HandleNotification action) {
  return null;
}
