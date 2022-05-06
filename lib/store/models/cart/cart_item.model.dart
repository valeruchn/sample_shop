// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItemModel {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String property;
  final int weight;
  final String photo;
  final String description;
  final String category;
  final int count;
  final int price;

  CartItemModel(
      {required this.id,
      required this.title,
      required this.property,
      required this.weight,
      required this.description,
      required this.photo,
      required this.category,
      required this.count,
      required this.price});

  // конвертация из JSON в обьект
  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
