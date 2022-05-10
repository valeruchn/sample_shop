// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/store/actions/cart.action.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.product}) : super(key: key);
  final CartItemModel product;

  // Добавление или удаление колличества
  void Function({required String id, required String option}) _incDecHandler(
          Store<AppState> store) =>
      ({required String id, required String option}) {
        if (option == 'inc') {
          store.dispatch(AddToCartPending(id: id, count: 1));
        } else if (option == 'dec') {
          store.dispatch(DecrementItemFromCartPending(id: id));
        }
      };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routemaster.of(context).push('/cart/product/${product.id}');
      },
      child: Container(
        decoration: BoxDecoration(
            color: kItemBackgroundColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 5.00, vertical: 7.00),
        // размер одного елемента 15% от высоты екрана
        height: MediaQuery.of(context).size.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Изображение
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(15.00)),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://10.0.2.2/products/photo/${product.photo}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Название и колличество
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      product.title,
                      style: const TextStyle(fontSize: 17.00),
                    ),
                  ),
                  StoreConnector<
                          AppState,
                          Function(
                              {required String id, required String option})>(
                      converter: _incDecHandler,
                      builder: (context, changeCount) => Row(
                            children: [
                              IconButton(
                                  splashRadius: 4.00,
                                  iconSize: 12.00,
                                  color: kDecrementButtonColor,
                                  onPressed: () => changeCount(
                                      id: product.id, option: 'dec'),
                                  icon: const FaIcon(FontAwesomeIcons.minus)),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.00, horizontal: 17.00),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: kDefaultLabelTextColor),
                                      borderRadius:
                                          BorderRadius.circular(10.00)),
                                  child: Text('${product.count}',
                                      style: const TextStyle(fontSize: 17.00))),
                              IconButton(
                                  splashRadius: 4.00,
                                  iconSize: 12.00,
                                  color: kIncrementButtonColor,
                                  onPressed: () => changeCount(
                                      id: product.id, option: 'inc'),
                                  icon: const FaIcon(FontAwesomeIcons.plus))
                            ],
                          )),
                ],
              ),
            ),
            // Удаление и цена
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StoreConnector<AppState, dynamic>(
                    converter: (store) => () =>
                        store.dispatch(DeleteFromCartPending(id: product.id)),
                    builder: (context, remove) => IconButton(
                      icon: const FaIcon(FontAwesomeIcons.trashCan,
                          color: kDeleteIconColor),
                      onPressed: remove,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15, bottom: 15),
                    child: Text(
                      '${product.price} $kCurrencyUah/од',
                      style: const TextStyle(fontSize: 17.00),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
