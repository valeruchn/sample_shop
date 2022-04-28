// Package imports:
import 'package:json_annotation/json_annotation.dart';
// Project imports:
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';


part 'cart.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartModel {
  final List<CartItemModel> cartItems;
  final int totalPrice;

  CartModel({
    required this.cartItems,
    required this.totalPrice,
  });

  // конвертация из JSON в обьект
  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
