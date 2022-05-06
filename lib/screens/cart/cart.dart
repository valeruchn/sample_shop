// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/screens/cart/cart_item.dart';

// Project imports:
import 'package:sample_shop/screens/order_confirmation/order_confirmation.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(kCartScreenTitleText)),
      body: StoreConnector<AppState, List<CartItemModel>>(
        onInit: (store) {
          if (store.state.cart.cartItems.isEmpty) {
            store.dispatch(GetCartPending());
          }
        },
        converter: ((store) => store.state.cart.cartItems),
        builder: ((context, products) => Column(
              children: [
                Expanded(
                  child: ListView(children: <Widget>[
                    ...products
                        .map((product) => CartItem(product: product))
                        .toList()
                  ]),
                ),
                StoreConnector<AppState, int>(
                    converter: ((store) => store.state.cart.totalPrice),
                    builder: ((context, totalPrice) => Container(
                          color: kAppAndNavBarColor,
                          padding: const EdgeInsets.all(10.00),
                          child: Column(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.all(10.00),
                              child: Text(
                                  '$kTotalPriceText: $totalPrice $kCurrencyUah',
                                  style: const TextStyle(fontSize: 17.00)),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.00),
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Order()));
                                  },
                                  child: const Text(kApplyOrderText)),
                            )
                          ]),
                        )))
              ],
            )),
      ),
    );
  }
}
