// Package imports
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:sample_shop/store/models/categories/subcategory.model.dart';


part 'category.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryModel {
  CategoryModel({
    required this.id,
    required this.title,
    required this.category,
    required this.subcategories
  });

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String category;
  final List<SubCategoryModel> subcategories;

  // конвертация из JSON в обьект
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}