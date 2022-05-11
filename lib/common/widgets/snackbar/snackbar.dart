import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/store/models/notification/notification.model.dart';

SnackBar snackBar(BuildContext context, NotificationModel notification) => SnackBar(
      // фиксированный или нет
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10.00),
    content: SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(notification.message, style: const TextStyle(fontSize: 17.00, fontWeight: FontWeight.w600)),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.circleXmark,
                color: kDefaultTextColor),
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,)
        ],
      ),
    ),
      backgroundColor: _getColor(notification.type),
    );

Color _getColor(NotificationType type) {
  switch (type) {
    case NotificationType.error:
      return Colors.red;
    case NotificationType.success:
      return Colors.green;
    case NotificationType.warning:
      return Colors.orange;
    default:
      return Colors.orange;
  }
}
