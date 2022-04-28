// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_dto.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderDtoModel _$CreateOrderDtoModelFromJson(Map<String, dynamic> json) =>
    CreateOrderDtoModel(
      firstName: json['firstName'] as String,
      phone: json['phone'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => CartQueryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateOrderDtoModelToJson(
        CreateOrderDtoModel instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
      'firstName': instance.firstName,
      'phone': instance.phone,
      'address': instance.address.toJson(),
    };
