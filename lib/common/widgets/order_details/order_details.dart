// Flutter imports:
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/helpers/utils/conver_order_status.dart';
import 'package:sample_shop/common/widgets/decorations/form_border_container.dart';
import 'package:sample_shop/common/widgets/decorations/form_title_text_container.dart';
import 'package:sample_shop/common/widgets/decorations/order_details_field.dart';
import 'package:sample_shop/common/widgets/order_details/order_product_item.dart';

// Package imports:
import 'package:sample_shop/store/models/order/current_order.model.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key, required this.order}) : super(key: key);
  final CurrentOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.00),
      child: Column(
        children: [
          Column(
            children: [
              const FormTitleTextContainer(text: kOrderDetailsTitleText),
              FormBorderContainer(
                child: Column(
                  children: [
                    OrderDetailsCustomField(
                        title: kOrderIdText, description: order.oid),
                    OrderDetailsCustomField(
                        title: kOrderDateText,
                        description:
                            DateFormat('yyyy-MM-dd  HH:mm').format(order.date)),
                    OrderDetailsCustomField(
                        title: kStatusOrderText, description: convertOrderStatus(order.status)),
                    OrderDetailsCustomField(
                        title: kTotalPriceOrderText,
                        description:
                            '${order.totalPrice.toString()} $kCurrencyUah'),
                  ],
                ),
              ),
              const FormTitleTextContainer(text: kContactFieldsBlockTitleText),
              FormBorderContainer(
                child: Column(
                  children: [
                    OrderDetailsCustomField(
                        title: kNameLabelFieldText,
                        description: order.firstName),
                    OrderDetailsCustomField(
                        title: kTelephoneLabelFieldText,
                        description: order.phone),
                  ],
                ),
              ),
              const FormTitleTextContainer(text: kAddressFieldsBlockTitleText),
              FormBorderContainer(
                child: Column(
                  children: [
                    OrderDetailsCustomField(
                        title: kStreetLabelFieldText,
                        description: order.address.street),
                    OrderDetailsCustomField(
                        title: kHouseNumberFieldText,
                        description: order.address.houseNumber),
                    OrderDetailsCustomField(
                        title: kFlatFieldText,
                        description: order.address.flat ?? ''),
                  ],
                ),
              ),
              const FormTitleTextContainer(text: kOrderListTitleText),
              ...order.products
                  .map((product) => OrderProductItem(
                        product: product,
                      ))
                  .toList(),
              if (order.comment != null)
                Column(
                  children: [
                    const FormTitleTextContainer(text: kCommentToOrderText),
                    FormBorderContainer(
                      child: Column(
                        children: [
                          OrderDetailsCustomField(
                              title: '', description: order.comment ?? ''),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}
