// Package imports:
import 'package:json_annotation/json_annotation.dart';
// Project imports:

part 'address.model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressModel {
  AddressModel(
      {required this.street, required this.houseNumber, this.flat});

  final String street;
  final String houseNumber;
  String? flat;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
