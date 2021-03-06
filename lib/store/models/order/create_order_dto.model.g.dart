// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_dto.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderDtoModel _$CreateOrderDtoModelFromJson(Map<String, dynamic> json) =>
    CreateOrderDtoModel(
      firstName: json['firstName'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => CartQueryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$CreateOrderDtoModelToJson(
        CreateOrderDtoModel instance) =>
    <String, dynamic>{
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'firstName': instance.firstName,
      'address': instance.address.toJson(),
      'comment': instance.comment,
    };
