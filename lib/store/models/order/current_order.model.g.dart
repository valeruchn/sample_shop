// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentOrderModel _$CurrentOrderModelFromJson(Map<String, dynamic> json) =>
    CurrentOrderModel(
      id: json['_id'] as String,
      oid: json['oid'] as String,
      firstName: json['firstName'] as String,
      phone: json['phone'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$CurrentOrderModelToJson(CurrentOrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'oid': instance.oid,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice,
      'firstName': instance.firstName,
      'phone': instance.phone,
      'address': instance.address.toJson(),
      'status': instance.status,
      'date': instance.date.toIso8601String(),
    };
