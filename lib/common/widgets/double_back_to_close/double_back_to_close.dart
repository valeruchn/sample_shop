// Flutter imports:
import 'package:flutter/material.dart';
import 'package:sample_shop/common/helpers/routing/routes.dart';

// Project imports:
import 'package:sample_shop/common/widgets/snackbar/snackbar.dart';
import 'package:sample_shop/store/models/notification/notification.model.dart';

final GlobalKey<ScaffoldState> scaffoldNotificationKey =
    GlobalKey<ScaffoldState>();

class DoubleBackToClose extends StatefulWidget {
  const DoubleBackToClose({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<DoubleBackToClose> createState() => _DoubleBackToCloseState();
}

class _DoubleBackToCloseState extends State<DoubleBackToClose> {
  int popped = 0;

  Future<bool> _onWillPop(GlobalKey<NavigatorState> _navigatorKey) async {
    print('test');
    DateTime initTime = DateTime.now();
    popped += 1;
    if (popped >= 2) return true;
    if (scaffoldNotificationKey.currentContext != null) {
      ScaffoldMessenger.of(scaffoldNotificationKey.currentContext!)
          .showSnackBar(snackBar(
              context,
              NotificationModel(
                  type: NotificationType.warning, message: 'press to go out')))
          .closed;
    }
    // if timer is > 2 seconds reset popped counter
    if (DateTime.now().difference(initTime) >= const Duration(seconds: 2)) {
      popped = 0;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(navigatorStateKey),
      child: widget.child,
    );
  }
}
