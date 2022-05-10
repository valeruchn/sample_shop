// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/widgets/decorations/order_confirmation_bottom_bar.dart';
import 'package:sample_shop/screens/cart/cart_item.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void goToOrderConfirmationScreen(Store<AppState> store) => () {
          Routemaster.of(context).push('/cart/order-confirmation');
        };

    return Scaffold(
      appBar: AppBar(title: const Text(kCartScreenTitleText)),
      body: StoreConnector<AppState, List<CartItemModel>>(
        onInit: (store) {
          if (store.state.cart.cartItems.isEmpty) {
            store.dispatch(GetCartPending());
          }
        },
        converter: ((store) => store.state.cart.cartItems),
        builder: ((context, products) => products.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView(children: <Widget>[
                      ...products
                          .map((product) => CartItem(product: product))
                          .toList()
                    ]),
                  ),
                  OrderConfirmationBottomBar.confirm(
                      action: goToOrderConfirmationScreen),
                ],
              )
            // Если товаров нет, выводим кнопку с возвратом в каталог
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        height: 25.00,
                        child: Text(kCartIsEmptyText,
                            style: TextStyle(fontSize: 15.00))),
                    ElevatedButton(
                        onPressed: () {
                          Routemaster.of(context).push('/Home');
                        },
                        child: const Text(
                          kGotoCatalogText,
                          style: TextStyle(fontSize: 17.00),
                        ))
                  ],
                ),
              )),
      ),
    );
  }
}
