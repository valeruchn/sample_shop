// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_shop/common/widgets/auth/check_sms_modal.dart';

// Project imports:
import 'package:sample_shop/store/reducers/reducer.dart';

class _FilterModel extends Equatable {
  const _FilterModel(
      {this.codeSend = false, this.timeIsOut = false, this.phone});

  final bool codeSend;
  final bool timeIsOut;
  final String? phone;

  @override
  List<Object?> get props => [codeSend, timeIsOut, phone];
}

class AuthStateListener extends StatelessWidget {
  const AuthStateListener({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _FilterModel>(
        converter: (store) => _FilterModel(
            codeSend: store.state.auth.codeSend,
            timeIsOut: store.state.auth.timeIsOut,
            phone: store.state.user.phone),
        builder: (context, state) => child,
        onWillChange: (oldState, newState) {
          if (oldState != newState && newState.codeSend) {
            showDialog(
                context: context, builder: (context) => const CheckSmsModal());
          }
          // если телефон не пустой - редирект на профиль(?)
        },
        distinct: true);
  }
}
