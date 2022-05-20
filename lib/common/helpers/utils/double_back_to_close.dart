// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:back_button_interceptor/back_button_interceptor.dart';

// Project imports:
import 'package:sample_shop/common/widgets/snackbar/snackbar.dart';
import 'package:sample_shop/store/models/notification/notification.model.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

final GlobalKey<ScaffoldState> scaffoldNotificationKey =
    GlobalKey<ScaffoldState>();

class DoubleBackToCloseListener extends StatefulWidget {
  const DoubleBackToCloseListener({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<DoubleBackToCloseListener> createState() => _DoubleBackToCloseListenerState();
}

class _DoubleBackToCloseListenerState extends State<DoubleBackToCloseListener> {
  var popped = 0;
  var initTime = DateTime.now();

  void _exitApp() {
    SystemNavigator.pop();
  }

  @override
  void initState() {
    super.initState();
    // Добавляем прослушивание аппаратного нажатия назад
    // пакет back_button_interceptor
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  Future<bool> myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) =>
      _onWillPop();

  Future<bool> _onWillPop() async {
    popped += 1;
    // print('on will pop');
    // print('popped: $popped');
    if (popped == 2) {
      initTime = DateTime.now();
      // print('try show modal');
      if (scaffoldNotificationKey.currentContext != null) {
        ScaffoldMessenger.of(scaffoldNotificationKey.currentContext!)
            .showSnackBar(snackBar(
                context,
                NotificationModel(
                    type: NotificationType.warning,
                    message: kExitAppActionText),
                action: _exitApp));
      }
      // print('return from modal');
      return true;
    }
    // выход из приложения:
    if (popped == 3) {
      // print('exit app');
      _exitApp();
    }
    // сброс счетчика по истечению двух секунд
    Future.delayed(const Duration(seconds: 2), () {
      popped = 0;
    });
    // print('return false');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
