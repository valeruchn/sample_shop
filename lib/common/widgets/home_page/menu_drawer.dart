// Flutter imports:
import 'package:flutter/material.dart';

// Package imports
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';

// Flutter imports:
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key, required this.handleChangeTitle})
      : super(key: key);
  final void Function(String title) handleChangeTitle;

  void _handleChangeFilter(Store<AppState> store) =>
          (String category, String title, BuildContext context) {
        handleChangeTitle(title);
        if (category == 'favourites') {
          store.dispatch(GetFavouriteProductsPending());
        } else {
          store.dispatch(GetProductsPending(category: category));
        }
        Navigator.pop(context);
      };

  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: kBackGroundColor,
      child: StoreConnector<AppState, dynamic>(
        // Запрос товаров по категории меню и закрытие drawer
        converter: _handleChangeFilter,
        builder: (context, query) => ListView(
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.only(top: 20.00, left: 20.00, bottom: 30.00),
              child: const Text(
                kMenuTitleText,
                style: TextStyle(fontSize: 30.00),
              ),
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.pizzaSlice,
                color: kPrimaryColor,
              ),
              title: const Text(kPizzaCategoryTitleText),
              onTap: () => query('pizza', kPizzaCategoryTitleText, context),
            ),
            ListTile(
              leading: const Icon(Icons.support_sharp, color: kPrimaryColor),
              title: const Text(kRollsCategoryTitleText),
              onTap: () => query('rolls', kRollsCategoryTitleText, context),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.kitchenSet,
                  color: kPrimaryColor),
              title: const Text(kSetsCategoryTitleText),
              onTap: () => query('sets', kSetsCategoryTitleText, context),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.solidHeart,
                  color: kPrimaryColor),
              title: const Text(kFavouriteCategoryTitleText),
              onTap: () =>
                  query('favourites', kFavouriteCategoryTitleText, context),
            ),
            ListTile(
              leading: const Icon(Icons.all_inclusive, color: kPrimaryColor),
              title: const Text('Всі'),
              onTap: () => query('all', kHomeScreenTitleText, context),
            ),
          ],
        ),
      ),
    );
  }
}
