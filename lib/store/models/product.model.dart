// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'product.model.g.dart';

@JsonSerializable()
class ProductModel {
  // когда в JSON другое имя свойства
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String property;
  final int weight;
  final String photo;
  final String description;
  final String category;
  final int price;

  ProductModel({
      required this.id,
      required this.title,
      required this.property,
      required this.weight,
      required this.description,
      required this.category,
      required this.price,
      required this.photo
    });

  // конвертация из JSON в обьект
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
