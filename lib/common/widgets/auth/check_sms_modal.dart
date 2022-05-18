// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/services/auth.service.dart';
import 'package:sample_shop/common/widgets/auth/auth_action.button.widget.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

// Ключь к состоянию модального окна
// используется для управления им из других виджетов
final pinCodeModalGlobalKey = GlobalKey<_CheckSmsModalState>();

class CheckSmsModal extends StatefulWidget {
  const CheckSmsModal({Key? key}) : super(key: key);

  @override
  State<CheckSmsModal> createState() => _CheckSmsModalState();
}

class _CheckSmsModalState extends State<CheckSmsModal> {
  final _codeController = TextEditingController();
  bool _isEmptyInput = false;

  void _checkSms(String? verificationId, String? code) {
    if (verificationId != null &&
        code != null &&
        verificationId.isNotEmpty &&
        code.isNotEmpty) {
      authService.signInWithPhoneCheckSms(verificationId, code, context);
    } else if (code == null || code.isEmpty) {
      setState(() {
        _isEmptyInput = true;
      });
    }
  }

  Widget _errorMessage(String message) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 4.00),
        child: Text(message,
            style: const TextStyle(
                color: kErrorFieldLabelColor, fontSize: 15.00)));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onWillChange: (oldState, newState) {
          if (((oldState?.auth.timeIsOut != newState.auth.timeIsOut) &&
              newState.auth.timeIsOut)) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
        distinct: true,
        builder: (context, state) => AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
              backgroundColor: kBackGroundColor,
              // скругление углов
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              actionsPadding: const EdgeInsets.only(right: 10.00),
              title: const Text(kEnterSmsCodeLabelText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kDefaultLabelTextColor)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: kDefaultLabelTextColor, fontSize: 20.00),
                    controller: _codeController,
                    onChanged: (value) {
                      setState(() {
                        _isEmptyInput = false;
                      });
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kDefaultBorderColor))),
                  ),
                  if ((state.auth.wrongSmsCode && !_isEmptyInput) ||
                      (state.auth.verificationFailed != null && !_isEmptyInput))
                    _errorMessage(kWrongSmsCodeLabelText),
                  if (_isEmptyInput) _errorMessage(kRequiredCodeFieldLabelText)
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: <Widget>[
                FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    margin: const EdgeInsets.only(left: 12.00),
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          color: kDefaultLabelTextColor,
                        ),
                        const SizedBox(
                          width: 10.00,
                        ),
                        if (state.auth.timer != null)
                          Text(
                            state.auth.timer.toString(),
                            style: const TextStyle(
                                fontSize: 15.00, fontWeight: FontWeight.w700),
                          )
                      ],
                    ),
                  ),
                ),
                AuthActionButton(
                  action: () => _checkSms(
                      state.auth.verificationId, _codeController.text),
                ),
              ],
            ));
  }
}
