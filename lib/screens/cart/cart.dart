// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/screens/order_confirmation/order_confirmation.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: StoreConnector<AppState, List<CartItemModel>>(
        onInit: (store) {
          if (store.state.cart.cartItems.isEmpty) {
            store.dispatch(GetCartPending());
          }
        },
        converter: ((store) => store.state.cart.cartItems),
        builder: ((context, products) => ListView(children: <Widget>[
              ...products
                  .map((product) => Container(
                        margin: const EdgeInsets.all(5.0),
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Image(
                                  image: NetworkImage(
                                      "http://10.0.2.2/products/photo/${product.photo}")),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.title),
                                    StoreConnector<AppState, Function({String id, String option})>(
                                        converter: (store) => (
                                                {String id = '',
                                                String option = ''}) {
                                              if (option == 'inc') {
                                                return store.dispatch(
                                                    AddToCartPending(
                                                        id: id, count: 1));
                                              } else if (option == 'dec') {
                                                return store.dispatch(
                                                    DecrementItemFromCartPending(
                                                        id: id));
                                              }
                                            },
                                        builder: (context, changeCount) => Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () => changeCount(id: product.id, option: 'dec'),
                                                    child: const Text('-')),
                                                Text('${product.count}'),
                                                TextButton(
                                                    onPressed: () => changeCount(id: product.id, option: 'inc'),
                                                    child: const Text('+')),
                                              ],
                                            )),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                // padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    StoreConnector<AppState, dynamic>(
                                      converter: (store) => () =>
                                          store.dispatch(DeleteFromCartPending(
                                              id: product.id)),
                                      builder: (context, remove) => IconButton(
                                        // padding: const EdgeInsets.only(right: 5, bottom: 5),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 25.0,
                                        ),
                                        onPressed: remove,
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(
                                            right: 10, bottom: 5),
                                        child: Text('${product.price}'))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList()
            ])),
      ),
      bottomSheet: StoreConnector<AppState, int>(
          converter: ((store) => store.state.cart.totalPrice),
          builder: ((context, totalPrice) => Row(children: [
                Text('Всего: $totalPrice'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Order()));
                    },
                    child: const Text('Подтвердить заказ'))
              ]))),
    );
  }
}
