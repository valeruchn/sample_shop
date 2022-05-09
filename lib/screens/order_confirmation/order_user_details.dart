// flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/widgets/decorations/form_border_container.dart';
import 'package:sample_shop/common/widgets/decorations/form_title_text_container.dart';
import 'package:sample_shop/common/widgets/decorations/order_confirmation_bottom_bar.dart';
import 'package:sample_shop/common/widgets/order_confirmation/order_confirmation_form_field.dart';
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/cart/cart.model.dart';
import 'package:sample_shop/store/models/cart/cart_query.model.dart';
import 'package:sample_shop/store/models/order/create_order_dto.model.dart';
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/models/user/address.model.dart';

// Project imports:
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class OrderUserDetails extends StatefulWidget {
  const OrderUserDetails({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<OrderUserDetails> createState() => _OrderUserDetailsState();
}

class _OrderUserDetailsState extends State<OrderUserDetails> {
  // ключь для управления формой
  final _formKey = GlobalKey<FormState>();

  // контроллеры формы
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _houseNumberController = TextEditingController();
  TextEditingController _flatController = TextEditingController();

  // инициализация контроллеров
  @override
  void initState() {
    _initControllers();
    super.initState();
  }

  // инициализация контроллеров
  void _initControllers() {
    _phoneController = TextEditingController(text: widget.user.phone);
    _nameController = TextEditingController(text: widget.user.firstName);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserModel>(
      onInit: (store) => store.dispatch(GetUserProfilePending()),
      converter: (store) => store.state.user,
      builder: (context, user) {
        // form
        return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const FormTitleTextContainer(
                  text: kContactFieldsBlockTitleText,
                ),
                // Container(
                //     margin: const EdgeInsets.symmetric(vertical: 20.0),
                //     child: const Text(kContactFieldsBlockTitleText)),
                FormBorderContainer(
                  child: Column(
                    children: [
                      OrderConfirmationFormField(
                          controller: _nameController,
                          isEditing: true,
                          isRequired: true,
                          label: kNameLabelFieldText),
                      OrderConfirmationFormField(
                          controller: _phoneController,
                          isEditing: false,
                          isRequired: true,
                          label: kTelephoneLabelFieldText),
                    ],
                  ),
                ),
                const FormTitleTextContainer(
                  text: kAddressFieldsBlockTitleText,
                ),
                FormBorderContainer(
                  child: Column(
                    children: [
                      OrderConfirmationFormField(
                          controller: _streetController,
                          isEditing: true,
                          isRequired: true,
                          label: kStreetLabelFieldText),
                      OrderConfirmationFormField(
                          controller: _houseNumberController,
                          isEditing: true,
                          isRequired: true,
                          label: kHouseNumberFieldText),
                      OrderConfirmationFormField(
                          controller: _flatController,
                          isEditing: true,
                          isRequired: false,
                          label: kFlatFieldText),
                    ],
                  ),
                ),
                OrderConfirmationBottomBar.apply(action: (){}),
                /*StoreConnector<AppState, CartModel>(
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
                                  // createOrder(CreateOrderDtoModel(
                                  //   firstName: _nameController.text,
                                  //   address: AddressModel(
                                  //       street: _streetController.text,
                                  //       houseNumber: _houseNumberController.text),
                                  //   // todo получать корзину в epic
                                  //   products: cart.cartItems
                                  //       .map((i) => CartQueryModel(
                                  //           id: i.id, count: i.count))
                                  //       .toList(),
                                  // ));
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
                ),*/
              ],
            ));
      },
    );
  }
}
