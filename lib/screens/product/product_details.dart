// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:badges/badges.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/common/helpers/utils/favorite_product_handler.dart';

// Project imports:
import 'package:sample_shop/common/widgets/modals/add_to_cart_modal.dart';
import 'package:sample_shop/common/widgets/preloader/preloader.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/models/products/product.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductModel?>(
        onInit: (store) =>
            store.dispatch(GetProductPending(productId: productId)),
        converter: (store) => store.state.currentProduct,
        builder: (context, product) => Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Badge(
                    badgeContent: StoreConnector<AppState, String>(
                        converter: (store) =>
                            store.state.cart.cartItems.length.toString(),
                        builder: (context, itemsCount) => Text(itemsCount)),
                    child: const Icon(Icons.shopping_cart),
                  ),
                  onPressed: () => Routemaster.of(context).push('/cart'),
                )
              ],
            ),
            body: product == null
                ? const Preloader()
                : Container(
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "http://10.0.2.2/products/photo/${product.photo}"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.topRight,
                              child: StoreConnector<AppState, dynamic>(
                                converter: (store) => favouriteProductHandler
                                    .useHandler(store, productId, context),
                                builder: (context, handler) => IconButton(
                                  icon: favouriteProductHandler
                                      .favouriteIcon(handler['isFavourite']),
                                  onPressed: handler['action'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ListView(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 5, bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      product.title,
                                      style: const TextStyle(fontSize: 25.0),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        '${product.price.toString()} грн',
                                        style: const TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 5.0, bottom: 5.0),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Описание',
                                        style: TextStyle(fontSize: 17)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Вес: ${product.weight}'),
                                          Text('Размер: ${product.property}'),
                                          Text(product.description)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 60.0)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              decoration: const BoxDecoration(color: Colors.black),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                  onPressed: () => addToCartModalDialog(context, productId),
                  child: const Text('Додати у кошик')),
            )));
  }
}
