// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routemaster/routemaster.dart';
// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/utils/favorite_product_handler.dart';
import 'package:sample_shop/common/widgets/modals/add_to_cart_modal.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

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
    // Перейти на страницу товара
    void _openProductDetails() {
      Routemaster.of(context).push('/product/$id');
    }

    return Container(
      decoration: const BoxDecoration(
          color: kProductItemBackgroundColor,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
          ]),
      child: InkWell(
        onTap: _openProductDetails,
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
                child: Container(
                  alignment: Alignment.topRight,
                  child: StoreConnector<AppState, dynamic>(
                    converter: (store) =>
                        favouriteProductHandler.useHandler(store, id, context),
                    builder: (context, handler) => IconButton(
                      icon: favouriteProductHandler
                          .favouriteIcon(handler['isFavourite']),
                      onPressed: handler['action'],
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
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      '${weight.toString()} гр',
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
                    ),
                  ),
                  IconButton(
                      padding: const EdgeInsets.only(right: 5, bottom: 5),
                      color: kShoppingCartIconColor,
                      icon: const FaIcon(FontAwesomeIcons.basketShopping),
                      onPressed: () => addToCartModalDialog(context, id))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
