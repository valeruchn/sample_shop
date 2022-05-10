import 'package:flutter/material.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';

class OrderDetailsCustomField extends StatelessWidget {
  const OrderDetailsCustomField(
      {Key? key, required this.title, required this.description})
      : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.00, vertical: 5.00),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 17.00),
          ),
          const SizedBox(
            width: 7.00,
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 17.00),
          ),
        ],
      ),
    );
  }
}
