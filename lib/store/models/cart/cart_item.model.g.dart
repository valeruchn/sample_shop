// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      property: json['property'] as String,
      weight: json['weight'] as int,
      description: json['description'] as String,
      photo: json['photo'] as String,
      category: json['category'] as String,
      count: json['count'] as int,
      price: json['price'] as int,
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'property': instance.property,
      'weight': instance.weight,
      'photo': instance.photo,
      'description': instance.description,
      'category': instance.category,
      'count': instance.count,
      'price': instance.price,
    };
