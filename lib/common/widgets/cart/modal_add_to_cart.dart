import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

void addToCartModalDialog(BuildContext context, String id) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        int countItems = 1;

        // Добавить одну позицию к заказу в модальном окне
        void _incrementCount(Function setState) {
          setState(() {
            countItems = countItems + 1;
          });
        }

        // Отнять одну позицию от заказа в модальном окне
        void _decrementCount(Function setState) {
          if (countItems > 1) {
            setState(() {
              countItems = countItems - 1;
            });
          }
        }

        return StatefulBuilder(builder: (context, setState) {
          return Center(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(/*width: 1, color: Colors.blue*/),
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Введите количество',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 15.00,
                    color: Colors.white,

                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                        onPressed: () => _decrementCount(setState),
                        child: const Text('-',
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                    Text('$countItems шт',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15.0,
                          color: Colors.white,
                        )),
                    TextButton(
                        onPressed: () => _incrementCount(setState),
                        child: const Text('+',
                            style: TextStyle(
                              color: Colors.white,
                            )))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Отменить',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () => Navigator.pop(context),
                    ),
                    StoreConnector<AppState, dynamic>(
                      converter: (store) =>
                          () => store.dispatch(AddToCartPending(
                                id: id,
                                count: countItems,
                              )),
                      builder: (context, add) => TextButton(
                        child: const Text('Подтвердить',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () {
                          add();
                          Routemaster.of(context)..pop()..push('/Cart');
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
        });
      });
}
