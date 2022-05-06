// Package imports
import 'package:json_annotation/json_annotation.dart';

// Project imports:


part 'subcategory.model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubCategoryModel {
  SubCategoryModel({
    required this.id,
    required this.subcategory_title,
    required this.subcategory
});

  @JsonKey(name: '_id')
  final String id;
  final String subcategory_title;
  final String subcategory;

  // конвертация из JSON в обьект
  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);

  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$SubCategoryModelToJson(this);
}