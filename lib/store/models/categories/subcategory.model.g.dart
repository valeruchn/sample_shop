// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) =>
    SubCategoryModel(
      id: json['_id'] as String,
      subcategory_title: json['subcategory_title'] as String,
      subcategory: json['subcategory'] as String,
    );

Map<String, dynamic> _$SubCategoryModelToJson(SubCategoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'subcategory_title': instance.subcategory_title,
      'subcategory': instance.subcategory,
    };
