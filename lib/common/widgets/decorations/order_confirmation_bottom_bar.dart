// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class OrderConfirmationBottomBar extends StatelessWidget {
  const OrderConfirmationBottomBar.confirm(
      {Key? key, required this.action, this.buttonText = kApplyOrderText})
      : super(key: key);

  const OrderConfirmationBottomBar.apply(
      {Key? key, required this.action, this.buttonText = kApplyOrderButtonText})
      : super(key: key);
  final String buttonText;
  final Function(Store<AppState> store) action;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
        converter: ((store) => store.state.cart.totalPrice),
        builder: ((context, totalPrice) => Container(
              color: kAppAndNavBarColor,
              padding: const EdgeInsets.all(10.00),
              child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(10.00),
                  child: Text('$kTotalPriceText: $totalPrice $kCurrencyUah',
                      style: const TextStyle(fontSize: 17.00)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.00),
                  width: double.infinity,
                  child: StoreConnector<AppState, dynamic>(
                    converter: action,
                    builder: (context, cb) => ElevatedButton(
                        onPressed: cb,
                        child: Text(
                          buttonText,
                          style: const TextStyle(fontSize: 17.00),
                        )),
                  ),
                )
              ]),
            )));
  }
}
