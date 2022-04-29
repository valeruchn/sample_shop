// Flutter imports:
import 'package:flutter/material.dart';

// Package import
import 'package:flutter_redux/flutter_redux.dart';
import 'package:routemaster/routemaster.dart';

// Project import
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/screens/home_page/add_to_cart_modal.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.property,
      required this.weight,
      required this.description,
      required this.price,
      required this.photo,
      required this.category});

  final String id;
  final String title;
  final String property;
  final int weight;
  final String description;
  final int price;
  final String photo;
  final String category;

  @override
  Widget build(BuildContext context) {
    void _openProductDetails() {
      Routemaster.of(context).push('/product/$id');
    }

    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFF141A1C),
          boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Colors.black,
              offset: Offset(1, 3))]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: InkWell(
              onTap: _openProductDetails,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage("http://10.0.2.2/products/photo/$photo"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    property,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${weight.toString()} гр',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    '$price грн',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                AddToCartModal(id: id)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
