import 'package:flutter/material.dart';
import 'package:sample_shop/screens/order_confirmation/order_user_details.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Подтверждение заказа'),),
      body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: const <Widget>[
            OrderUserDetails(),
          ],),
      ),
      );
  }
}
