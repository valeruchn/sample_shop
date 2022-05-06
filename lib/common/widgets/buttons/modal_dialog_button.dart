import 'package:flutter/material.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

class ModalDialogButton extends StatelessWidget {
  ModalDialogButton.apply(
      {Key? key,
      required this.action,
      this.color = kPrimaryColor,
      this.text = kConfirm})
      : super(key: key);

  ModalDialogButton.cancel(
      {Key? key,
      required this.action,
      this.color = Colors.grey,
      this.text = kCancel})
      : super(key: key);

  Function() action;
  Color color;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.00),
      height: 40.00,
      width: 120.00,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color)),
          onPressed: action,
          child: Text(text, maxLines: 1)),
    );
  }
}
