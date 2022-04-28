// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'cartItems': instance.cartItems.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice,
    };
