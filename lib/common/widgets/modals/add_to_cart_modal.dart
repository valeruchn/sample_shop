import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/widgets/buttons/modal_dialog_button.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

void addToCartModalDialog(BuildContext context, String id) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AddToCartModal(
            id: id,
          ));
}

class AddToCartModal extends StatefulWidget {
  const AddToCartModal({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<AddToCartModal> createState() => _AddToCartModalState();
}

class _AddToCartModalState extends State<AddToCartModal> {
  int countItems = 1;

  // Добавить одну позицию к заказу в модальном окне
  void _incrementCount() {
    setState(() {
      countItems = countItems + 1;
    });
  }

  // Отнять одну позицию от заказа в модальном окне
  void _decrementCount() {
    if (countItems > 1) {
      setState(() {
        countItems = countItems - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: kBackGroundColor,
              borderRadius: BorderRadius.circular(20)),
          child: Material(
            color: kBackGroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  kAddToCartEnterCountText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.00,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        iconSize: 15.00,
                        color: kDecrementButtonColor,
                        onPressed: () => _decrementCount(),
                        icon: const FaIcon(FontAwesomeIcons.minus)),
                      Text('$countItems шт',
                        style: const TextStyle(
                          fontSize: 20.0,
                        )),
                      IconButton(
                        iconSize: 15.00,
                        color: kIncrementButtonColor,
                        onPressed: () => _incrementCount(),
                        icon: const FaIcon(FontAwesomeIcons.plus)),
                  ],
                  ),
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ModalDialogButton.cancel(
                      text: kCancelAddToCart,
                      action: () => Routemaster.of(context).pop()),
                  StoreConnector<AppState, dynamic>(
                      converter: (store) => () => store.dispatch(AddToCartPending(
                            id: widget.id,
                            count: countItems,
                          )),
                      builder: (context, add) => ModalDialogButton.apply(
                          text: kConfirmAddToCart,
                          action: () {
                            add();
                            Routemaster.of(context).pop();
                          }))
                ],
              ),
            ],
          ),
        ),
      ));
    }
}
