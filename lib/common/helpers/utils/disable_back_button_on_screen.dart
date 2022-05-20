import 'package:flutter/material.dart';

class MySwipeDisable extends StatelessWidget {
  final Widget child;
  final bool disable;

  const MySwipeDisable({Key? key, required this.child, required this.disable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return disable
        ? WillPopScope(child: child, onWillPop: () async => false)
        : child;
  }
}
