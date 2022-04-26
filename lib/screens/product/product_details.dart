import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/helpers/constants/font_settings.dart';
import 'package:sample_shop/common/widgets/cart/modal_add_to_cart.dart';
import 'package:sample_shop/store/models/product.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductModel>(
        converter: (store) => store.state.products
            .where((element) => element.id == productId)
            .first,
        builder: (context, product) => Scaffold(
            appBar: AppBar(/*title: Text(product.title)*/),
            body: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                children: [
                  Image(
                      image: NetworkImage(
                          "http://10.0.2.2/products/photo/${product.photo}"),
                      fit: BoxFit.contain),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 5, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 25.0, color: kPrimaryTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            '${product.price.toString()} грн',
                            style: const TextStyle(
                                fontSize: 15.0, color: kPrimaryTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 5.0, bottom: 5.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Описание',
                            style: TextStyle(
                                fontSize: 17, color: kPrimaryTextColor)),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Вес: ${product.weight}',
                                  style: const TextStyle(
                                      color: kPrimaryTextColor)),
                              Text('Размер: ${product.property}',
                                  style: const TextStyle(
                                      color: kPrimaryTextColor)),
                              Text(product.description,
                                  style:
                                      const TextStyle(color: kPrimaryTextColor))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                        onPressed: () => addToCartModalDialog(context, productId),
                        child: const Text('Добавить в корзину')),
                  )
                ],
              ),
            )));
  }
}
