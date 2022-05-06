// Flutter imports:
import 'package:flutter/material.dart';

// Package imports
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sample_shop/common/helpers/constants/search_category_object_constants.dart';

// Flutter imports:
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key, required this.handleChangeTitle})
      : super(key: key);
  final void Function(String title) handleChangeTitle;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  bool _isOpenSubCatMenu = false;

  // Открыть подкатегории
  void _toggleSubCatMenu() {
    setState(() {
      _isOpenSubCatMenu = !_isOpenSubCatMenu;
    });
  }

  // Переключение фильтра
  void _handleChangeFilter(Store<AppState> store) => (String category,
          String title, BuildContext context, String? subcategory) {
        widget.handleChangeTitle(title);
        if (category == kFavouriteCategorySearch.category) {
          store.dispatch(GetFavouriteProductsPending());
        } else {
          store.dispatch(
              GetProductsPending(category: category, subcategory: subcategory));
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
              title: Text(kPizzaCategorySearch.title),
              onTap: () => query(kPizzaCategorySearch.category,
                  kPizzaCategorySearch.title, context, null),
            ),
            // Выпадающее меню
            ListTile(
                leading: const Icon(Icons.support_sharp, color: kPrimaryColor),
                title: const Text(kRollsCategoryTitleText),
                onTap: _toggleSubCatMenu),
            if (_isOpenSubCatMenu)
              Column(
                children: [
                  const Divider(
                    color: kDefaultBorderColor,
                    height: 0.00,
                  ),
                  ...kDropDownButtonSubcategoryList
                      .map((subcategory) => ListTile(
                          leading: Container(
                            margin:
                                const EdgeInsets.only(left: 15.00, top: 5.5),
                            child: const FaIcon(
                              FontAwesomeIcons.circleDot,
                              size: 12.00,
                              color: kPrimaryColor,
                            ),
                          ),
                          title: Container(
                              margin: const EdgeInsets.only(left: 10.00),
                              child: Text(subcategory.title)),
                          onTap: () => query(
                              subcategory.category,
                              subcategory.title,
                              context,
                              subcategory.subcategory)))
                      .toList(),
                  const Divider(
                    color: kDefaultBorderColor,
                    height: 0.00,
                  ),
                ],
              ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.kitchenSet,
                  color: kPrimaryColor),
              title: Text(kSetsCategorySearch.title),
              onTap: () => query(kSetsCategorySearch.category,
                  kSetsCategorySearch.title, context, null),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.solidHeart,
                  color: kPrimaryColor),
              title: Text(kFavouriteCategorySearch.title),
              onTap: () => query(kFavouriteCategorySearch.category,
                  kFavouriteCategorySearch.title, context, null),
            ),
            ListTile(
              leading: const Icon(Icons.all_inclusive, color: kPrimaryColor),
              title: Text(kAllCategorySearch.title),
              onTap: () => query(
                  kAllCategorySearch.category, kHomeScreenTitleText, context, null),
            ),
          ],
        ),
      ),
    );
  }
}
