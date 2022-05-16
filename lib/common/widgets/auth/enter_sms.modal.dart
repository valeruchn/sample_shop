// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';

class EnterSmsAuthModal extends StatelessWidget {
  const EnterSmsAuthModal(
      {Key? key,
      required this.codeController,
      required this.action,
      required this.wrongSmsCode})
      : super(key: key);
  final TextEditingController codeController;
  final bool wrongSmsCode;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            style:
                const TextStyle(color: kDefaultLabelTextColor, fontSize: 20.00),
            controller: codeController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kDefaultBorderColor))),
          ),
          if(wrongSmsCode) Container(
            alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 4.00),
              child: const Text('невірний код', style: TextStyle(color: kErrorFieldLabelColor, fontSize: 15.00)))
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text(kSendSmsCodeButtonText),
          onPressed: action,
        ),
      ],
    );
  }
}
