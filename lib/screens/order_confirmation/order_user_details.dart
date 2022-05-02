// flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';
import 'package:sample_shop/store/models/order/create_order_dto.model.dart';

// Project imports:
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/cart/cart.model.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/models/user/address.model.dart';

class OrderUserDetails extends StatefulWidget {
  const OrderUserDetails({Key? key}) : super(key: key);

  @override
  State<OrderUserDetails> createState() => _OrderUserDetailsState();
}

class _OrderUserDetailsState extends State<OrderUserDetails> {
  // ключь для управления формой
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserModel>(
      onInit: (store) =>
          store.dispatch(GetUserProfilePending()),
      converter: (store) => store.state.user,
      builder: (context, user) {
        // user form fields:
        final TextEditingController _name =
            TextEditingController(text: user.firstName);
        // address form fields
        final TextEditingController _street =
            TextEditingController(text: user.address?.street);
        final TextEditingController _houseNumber =
            TextEditingController(text: user.address?.houseNumber);
        final TextEditingController _flat =
            TextEditingController(text: user.address?.flat);
        // form validator
        String? _validator(String? value, String fieldName) {
          if (value == null || value.isEmpty) {
            return 'Введите $fieldName';
          }
          return null;
        }

        // form
        return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: const Text('Контактные данные')),
                TextFormField(
                  controller: _name,
                  maxLength: 30,
                  decoration: const InputDecoration(
                    hintText: 'Имя',
                    // не отображать счетчик количества символов
                    counterText: '',
                  ),
                  validator: (value) => _validator(value, 'имя'),
                ),
                TextFormField(
                  enabled: false,
                  initialValue: user.phone,
                  decoration: const InputDecoration(
                    hintText: 'Телефон',
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: const Text('Адрес')),
                TextFormField(
                  controller: _street,
                  maxLength: 30,
                  decoration: const InputDecoration(
                    hintText: 'Улица',
                    // не отображать счетчик количества символов
                    counterText: '',
                  ),
                  validator: (value) => _validator(value, 'название улицы'),
                ),
                TextFormField(
                  controller: _houseNumber,
                  maxLength: 30,
                  decoration: const InputDecoration(
                    hintText: 'Дом',
                    // не отображать счетчик количества символов
                    counterText: '',
                  ),
                  validator: (value) => _validator(value, 'номер дома'),
                ),
                TextFormField(
                  controller: _flat,
                  maxLength: 30,
                  decoration: const InputDecoration(
                    hintText: 'Квартира',
                    // не отображать счетчик количества символов
                    counterText: '',
                  ),
                ),
                StoreConnector<AppState, CartModel>(
                  converter: (store) => store.state.cart,
                  builder: (context, cart) => Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                                'Стоимость заказа: ${cart.totalPrice} грн')),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: StoreConnector<AppState, dynamic>(
                            converter: (store) => (CreateOrderDtoModel order) =>
                                store
                                    .dispatch(CreateOrderPending(order: order)),
                            builder: (context, createOrder) => ElevatedButton(
                              onPressed: () {
                                var _state = _formKey.currentState!;
                                if (_state.validate()) {
                                  createOrder(CreateOrderDtoModel(
                                    firstName: _name.text,
                                    address: AddressModel(
                                        street: _street.text,
                                        houseNumber: _houseNumber.text),
                                    // todo получать корзину в epic
                                    products: cart.cartItems
                                        .map((i) => CartQueryModel(
                                            id: i.id, count: i.count))
                                        .toList(),
                                  ));
                                }
                                // Navigator.pop(context);
                              },
                              child: const Text('Подтвердить заказ'),
                            ),
                          ),
                        ),
                        StoreConnector<AppState, CurrentOrderModel?>(
                            converter: (store) =>
                                store.state.orders.currentOrder,
                            // onInit: (store) {
                            //   if (store.state.orders.currentOrder != null) {
                            //     Routemaster.of(context).push(
                            //         '/Orders/${store.state.orders.currentOrder!.id}');
                            //   }
                            // },
                            builder: (context, currentOrder) => Row(
                                  children: [
                                    if (currentOrder != null)
                                      Text(
                                          'Заказ создан, статус: ${currentOrder.status}'),
                                  ],
                                ))
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
