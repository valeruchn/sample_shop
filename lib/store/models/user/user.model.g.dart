// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      phone: json['phone'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      email: json['email'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      favorits: (json['favorits'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'phone': instance.phone,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthdate': instance.birthdate?.toIso8601String(),
      'email': instance.email,
      'address': instance.address?.toJson(),
      'favorits': instance.favorits,
      'role': instance.role,
    };
