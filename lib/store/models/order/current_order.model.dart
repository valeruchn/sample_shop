// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:sample_shop/store/models/cart/cart_query.model.dart';
import 'package:sample_shop/store/models/user/address.model.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';

part 'current_order.model.g.dart';
// explicitToJson: true для преобразования вложенных обьектов в JSON
@JsonSerializable(explicitToJson: true)
class CurrentOrderModel {
  CurrentOrderModel({
    required this.firstName,
    required this.phone,
    required this.address,
    required this.products,
    this.status
  });

  final List<CartItemModel> products;
  final String firstName;
  final String phone;
  final AddressModel address;
  String? status;

  // конвертация из JSON в обьект
  factory CurrentOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentOrderModelFromJson(json);

  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$CurrentOrderModelToJson(this);
}
