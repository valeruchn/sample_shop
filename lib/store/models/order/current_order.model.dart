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
    required this.id,
    required this.oid,
    required this.firstName,
    required this.phone,
    required this.address,
    required this.products,
    required this.totalPrice,
    required this.status,
    required this.date,
    this.comment
  });

  @JsonKey(name: '_id')
  final String id;
  final String oid;
  final List<CartItemModel> products;
  final int totalPrice;
  final String firstName;
  final String phone;
  final AddressModel address;
  final String status;
  final DateTime date;
  final String? comment;

  // конвертация из JSON в обьект
  factory CurrentOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentOrderModelFromJson(json);

  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$CurrentOrderModelToJson(this);
}
