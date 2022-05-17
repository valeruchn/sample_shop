// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/store.dart';
import 'package:sample_shop/common/widgets/auth/check_sms_modal.dart';
import 'package:sample_shop/store/actions/auth.action.dart';

class _FilterModel extends Equatable {
  const _FilterModel(
      {this.codeSend = false, this.timeIsOut = false, this.phone});

  final bool codeSend;
  final bool timeIsOut;
  final String? phone;

  @override
  List<Object?> get props => [codeSend, timeIsOut, phone];
}

class AuthStateListener extends StatefulWidget {
  const AuthStateListener({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AuthStateListener> createState() => _AuthStateListenerState();
}

class _AuthStateListenerState extends State<AuthStateListener> {
  int _timeLimit = 60;
  Timer _timer = Timer(const Duration(seconds: 1), () {});

  void _startTimer() {
    setState(() {
      _timeLimit = 60;
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_timeLimit == 0) {
          setState(() {
            store.dispatch(AuthTimerIsOut());
            timer.cancel();
          });
        } else {
          setState(() {
            _timeLimit--;
          });
          store.dispatch(SetAuthTimer(timer: _timeLimit));
        }
      },
    );
  }

  @override
  void dispose() {
    store.dispatch(SetAuthTimer());
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _FilterModel>(
        converter: (store) => _FilterModel(
            codeSend: store.state.auth.codeSend,
            timeIsOut: store.state.auth.timeIsOut,
            phone: store.state.user.phone),
        builder: (context, state) => widget.child,
        onWillChange: (oldState, newState) {
          if (oldState != newState && newState.codeSend) {
            // Сбрасываем таймер
            if (_timer.isActive) {
              _timer.cancel();
              store.dispatch(SetAuthTimer());
            }
            _startTimer();
            // Показываем модальное окно
            showDialog(
                context: context,
                builder: (context) {
                  return const CheckSmsModal();
                });
          }
          // если телефон не пустой - редирект на профиль(?)
        },
        distinct: true);
  }
}
