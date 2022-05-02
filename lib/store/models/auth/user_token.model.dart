// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'user_token.model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserTokenModel {
  UserTokenModel({required this.token});

  final String token;

  // конвертация из JSON в обьект
  factory UserTokenModel.fromJson(Map<String, dynamic> json) =>
      _$UserTokenModelFromJson(json);

  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$UserTokenModelToJson(this);
}
