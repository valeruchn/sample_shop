// Package imports
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:sample_shop/store/models/order/current_order.model.dart';

part 'order.model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  OrderModel({this.currentOrder, this.ordersLog});

  CurrentOrderModel? currentOrder;
  List<CurrentOrderModel>? ordersLog;

  // конвертация из JSON в обьект
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  // конвертация из обьекта в JSON
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
