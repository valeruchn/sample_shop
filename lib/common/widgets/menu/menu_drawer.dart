// Flutter imports:
import 'package:flutter/material.dart';
// Package imports
import 'package:flutter_redux/flutter_redux.dart';
// Flutter imports:
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StoreConnector<AppState, dynamic>(
        // Запрос товаров по категории меню и закрытие drawer
        converter: (store) => (String category) {
          store.dispatch(GetProductsPending(category: category));
          Navigator.pop(context);
        },
        builder: (context, query) => ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Меню',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.local_pizza),
              title: const Text('Пицца'),
              onTap: () => query('pizza'),
            ),
            ListTile(
              leading: const Icon(Icons.support_sharp),
              title: const Text('Ролы'),
              onTap: () => query('rolls'),
            ),
            ListTile(
              leading: const Icon(Icons.support_sharp),
              title: const Text('Сеты'),
              onTap: () => query('sets'),
            ),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('Все'),
              onTap: () => query('all'),
            ),
          ],
        ),
      ),
    );
  }
}
