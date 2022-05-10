// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';

// Project imports:
import 'package:sample_shop/store/models/user/address.model.dart';

part 'create_order_dto.model.g.dart';

// explicitToJson: true для преобразования вложенных обьектов в JSON
@JsonSerializable(explicitToJson: true)
class CreateOrderDtoModel {
  CreateOrderDtoModel(
      {required this.firstName,
      required this.address,
      this.products,
      this.comment});

  final List<CartQueryModel>? products;
  final String firstName;
  final AddressModel address;
  final String? comment;

  // конвертация из JSON в обьект
  factory CreateOrderDtoModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderDtoModelFromJson(json);

  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$CreateOrderDtoModelToJson(this);
}
