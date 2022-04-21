// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:sample_shop/store/models/user/address.model.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.uid,
    required this.phone,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.email,
    this.address,
  });

  final String uid;
  String phone;
  String? firstName;
  String? lastName;
  DateTime? birthdate;
  String? email;
  AddressModel? address;

  // конвертация из JSON в обьект
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
