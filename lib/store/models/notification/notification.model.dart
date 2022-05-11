enum NotificationType { error, warning, success }

class NotificationModel {
  NotificationModel({required this.type, required this.message});
  NotificationType type;
  String message;
}