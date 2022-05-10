// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';

class FormBorderContainer extends StatelessWidget {
  const FormBorderContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10.00),
      padding: const EdgeInsets.symmetric(horizontal: 10.00, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1.0, color: kDefaultBorderColor)),
      child: child,
    );
  }
}
