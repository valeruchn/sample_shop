// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentOrderModel _$CurrentOrderModelFromJson(Map<String, dynamic> json) =>
    CurrentOrderModel(
      firstName: json['firstName'] as String,
      phone: json['phone'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CurrentOrderModelToJson(CurrentOrderModel instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice,
      'firstName': instance.firstName,
      'phone': instance.phone,
      'address': instance.address.toJson(),
      'status': instance.status,
    };
