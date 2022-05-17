// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton({Key? key, required this.action, this.primary = false})
      : super(key: key);
  final void Function()? action;
  final bool primary;

  bool _checkIsLoading(bool primary, AuthMobileModel state) {
    if (primary) {
      return state.isSendSmsLoading;
    } else {
      return state.isCheckSmsLoading;
    }
  }

  String _checkButtonText(bool primary, AuthMobileModel state) {
    return state.timeIsOut && primary
        ? kResendSmsCodeButtonText
        : kSendSmsCodeButtonText;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthMobileModel>(
      converter: (store) => store.state.auth,
      builder: (context, state) => ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                _checkIsLoading(primary, state)
                    ? kDeactivatedButtonColor
                    : kPrimaryColor)),
        onPressed: _checkIsLoading(primary, state) ? null : action,
        child: Text(_checkIsLoading(primary, state)
            ? kLoadingButtonTitleText
            : _checkButtonText(primary, state)),
      ),
    );
  }
}
