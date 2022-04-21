// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      currentOrder: json['currentOrder'] == null
          ? null
          : CurrentOrderModel.fromJson(
              json['currentOrder'] as Map<String, dynamic>),
      ordersLog: (json['ordersLog'] as List<dynamic>?)
          ?.map((e) => CurrentOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'currentOrder': instance.currentOrder?.toJson(),
      'ordersLog': instance.ordersLog?.map((e) => e.toJson()).toList(),
    };
