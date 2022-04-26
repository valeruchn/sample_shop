import 'package:flutter/cupertino.dart';
import 'package:sample_shop/screens/order/formOrderControlModel.dart';

class FormOrderControlProvider
    extends InheritedNotifier<FormOrderControlModel> {
  final FormOrderControlModel model;

  const FormOrderControlProvider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, notifier: model, child: child);

  static FormOrderControlModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormOrderControlProvider>()?.model;
  }
}
