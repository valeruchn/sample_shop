// Flutter imports:
import 'package:flutter/material.dart';

class FormTitleTextContainer extends StatelessWidget {
  const FormTitleTextContainer({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15.00),
        child: Text(
          text,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 17.00),
        ));
  }
}
