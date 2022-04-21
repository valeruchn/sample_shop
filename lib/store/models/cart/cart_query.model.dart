// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'cart_query.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartQueryModel {
  final String id;
  final int count;

  CartQueryModel({
    required this.id, 
    required this.count
    });

  // конвертация из JSON в обьект
  factory CartQueryModel.fromJson(Map<String, dynamic> json) =>
      _$CartQueryModelFromJson(json);
  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$CartQueryModelToJson(this);
}