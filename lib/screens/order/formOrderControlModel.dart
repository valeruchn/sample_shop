import 'package:flutter/cupertino.dart';
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/models/cart/cart_item.model.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/models/user/address.model.dart';

class FormOrderControlModel extends ChangeNotifier {
  String? _firstName;
  String? _phone;
  String? _street;
  String? _houseNumber;
  String? _flat;
  String status = 'incoming';

  String get firstName => _firstName ?? '';
  String get phone => _phone ?? '';

  set firstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  set street(String value) => _street = value;

  set houseNumber(String value) => _houseNumber = value;

  set flat(String value) => _flat = value;

  void createOrder(List<CartItemModel> products, dynamic Function(dynamic) dispatch) {
    CurrentOrderModel _order = CurrentOrderModel(
        firstName: _firstName ?? '',
        phone: _phone ?? '',
        address: AddressModel(
            street: _street ?? '',
            houseNumber: _houseNumber ?? '',
            flat: _flat),
        products: products,
        status: status);
        dispatch(CreateOrderPending(order: _order));
  }

}
