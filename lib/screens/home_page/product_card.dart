// Flutter imports:
import 'package:flutter/material.dart';

// Package import
import 'package:flutter_redux/flutter_redux.dart';


// Project import
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/screens/home_page/add_to_cart_modal.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {required this.id,
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

  // bool availableDeleteOption(List<CartItemModel> products){
  //   bool option = false;
  //   for (var product in products){
  //     if (product.id == id){
  //       option = true;
  //     }
  //   }
  //   return option;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.blue),
          // Скругление краев карточки товара
          // borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage("http://10.0.2.2/products/photo/$photo"),
                    fit: BoxFit.contain,
                  ),
                ),
                // child: Image(
                //   image: AssetImage(
                //     "assets/images/$id.jpg"
                //   ),
                //   fit: BoxFit.contain,
                // ),
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
              child: Container(
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
                    // StoreConnector<AppState, dynamic>(
                    //   converter: (store) =>
                    //       () => store.dispatch(AddToCartPending(
                    //             id: id,
                    //             count: 1,
                    //           )),
                    //   builder: (context, add) => IconButton(
                    //     padding: const EdgeInsets.only(right: 5, bottom: 5),
                    //     icon: const Icon(
                    //       Icons.shopping_bag_rounded,
                    //       color: Colors.green,
                    //       size: 25.0,
                    //     ),
                    //     onPressed: add,
                    //   ),
                    // ),
                    AddToCartModal(id: id)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
