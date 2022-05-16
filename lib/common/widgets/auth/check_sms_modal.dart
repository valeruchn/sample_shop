// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/services/auth.service.dart';
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

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
    return StoreConnector<AppState, AuthMobileModel>(
        converter: (store) => store.state.auth,
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
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kDefaultBorderColor))),
                  ),
                  if (state.wrongSmsCode && !_isEmptyInput)
                    _errorMessage(kWrongSmsCodeLabelText),
                  if (_isEmptyInput) _errorMessage(kRequiredCodeFieldLabelText)
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text(kSendSmsCodeButtonText),
                  onPressed: () =>
                      _checkSms(state.verificationId, _codeController.text),
                ),
              ],
            ));
  }
}
