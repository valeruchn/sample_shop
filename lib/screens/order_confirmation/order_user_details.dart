// flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/widgets/decorations/form_border_container.dart';
import 'package:sample_shop/common/widgets/decorations/form_title_text_container.dart';
import 'package:sample_shop/common/widgets/decorations/order_confirmation_bottom_bar.dart';
import 'package:sample_shop/common/widgets/order_confirmation/order_confirmation_form_field.dart';
import 'package:sample_shop/store/actions/order.action.dart';
import 'package:sample_shop/store/models/order/create_order_dto.model.dart';
import 'package:sample_shop/store/models/user/address.model.dart';

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
  TextEditingController _commentController = TextEditingController();

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

  // создание ордера
  void createOrder(Store<AppState> store) => () {
        var _formState = _formKey.currentState!;
        if (_formState.validate()) {
          final order = CreateOrderDtoModel(
              firstName: _nameController.text,
              comment: _commentController.text.isNotEmpty
                  ? _commentController.text
                  : null,
              address: AddressModel(
                  street: _streetController.text,
                  houseNumber: _houseNumberController.text));
          store.dispatch(CreateOrderPending(order: order));
          Routemaster.of(context).push('/new-order');
        }
      };

  @override
  Widget build(BuildContext context) {
    // form
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const FormTitleTextContainer(
                      text: kContactFieldsBlockTitleText,
                    ),
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
                    const FormTitleTextContainer(
                      text: kCommentToOrderText,
                    ),
                    FormBorderContainer(
                      child: Column(
                        children: [
                          OrderConfirmationFormField(
                            controller: _commentController,
                            isEditing: true,
                            isRequired: false,
                            label: kCommentLabelFieldText,
                            maxLength: 70,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            OrderConfirmationBottomBar.apply(action: createOrder),
          ],
        ));
  }
}
