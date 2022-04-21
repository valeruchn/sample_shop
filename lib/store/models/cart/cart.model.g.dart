// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      cartQueryParams: (json['cartQueryParams'] as List<dynamic>)
          .map((e) => CartQueryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'cartQueryParams':
          instance.cartQueryParams.map((e) => e.toJson()).toList(),
      'cartItems': instance.cartItems.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice,
    };
