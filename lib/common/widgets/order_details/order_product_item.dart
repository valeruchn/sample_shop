import 'package:flutter/material.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/connection.constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({Key? key, required this.product}) : super(key: key);

  final CartItemModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kItemBackgroundColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
                blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
          ]),
      margin: const EdgeInsets.symmetric(horizontal: 7.00, vertical: 7.00),
      // размер одного елемента 15% от высоты екрана
      height: MediaQuery.of(context).size.height * 0.12,
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
                      "$kProductsPhotoBaseUlt/${product.photo}"),
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
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    product.title,
                    style: const TextStyle(fontSize: 17.00),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 10.00, left: 10.00),
                    child: Text('${product.count} $kCountItemText.',
                        style: const TextStyle(fontSize: 17.00)))
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
                Container(
                  padding: const EdgeInsets.only(right: 15, top: 10),
                  alignment: Alignment.topRight,
                  child: const Text(
                    kPriceText,
                    style: TextStyle(fontSize: 17.00),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 15, bottom: 10),
                  child: Text(
                    '${product.price} $kCurrencyUah/$kCountItemText',
                    style: const TextStyle(fontSize: 17.00),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
