// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      property: json['property'] as String,
      weight: json['weight'] as int,
      description: json['description'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String?,
      price: json['price'] as int,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'property': instance.property,
      'weight': instance.weight,
      'photo': instance.photo,
      'description': instance.description,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'price': instance.price,
    };
