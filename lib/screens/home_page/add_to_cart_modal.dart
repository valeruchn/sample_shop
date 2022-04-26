// Flutter imports:
import 'package:flutter/material.dart';
import 'package:sample_shop/common/widgets/cart/modal_add_to_cart.dart';

class AddToCartModal extends StatelessWidget {
  const AddToCartModal({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: const EdgeInsets.only(right: 5, bottom: 5),
        icon: const Icon(
          Icons.shopping_bag_rounded,
          color: Colors.green,
          size: 25.0,
        ),
        onPressed: () => addToCartModalDialog(context, id));
  }
}
