// Flutter imports:
import 'package:flutter/material.dart';

// Package imports
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/common/helpers/constants/search_category_object_constants.dart';
import 'package:sample_shop/common/widgets/home_page/category_item.dart';
import 'package:sample_shop/store/actions/categories.action.dart';

// Flutter imports:
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/models/categories/category.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  // Переключение фильтра
  void _handleChangeFilter(Store<AppState> store) => (String? category) {
        if (store.state.user.phone.isEmpty &&
            category == kFavouriteCategorySearch.category) {
          Routemaster.of(context).push('/auth');
        } else if (category == kFavouriteCategorySearch.category) {
          store.dispatch(GetFavouriteProductsPending());
        } else {
          store.dispatch(GetProductsPending());
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
            StoreConnector<AppState, List<CategoryModel>>(
              onInit: (store) => store.dispatch(GetCategoriesPending()),
              converter: (store) => store.state.categories,
              builder: (context, categories) => Column(
                children: [
                  ...categories
                      .map((category) => CategoryItem(category: category))
                      .toList()
                ],
              ),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.solidHeart,
                  color: kPrimaryColor),
              title: Text(kFavouriteCategorySearch.title),
              onTap: () => query(kFavouriteCategorySearch.category),
            ),
            ListTile(
              leading: const Icon(Icons.all_inclusive, color: kPrimaryColor),
              title: const Text(kAllCategoryTitleText),
              onTap: () => query(null),
            ),
          ],
        ),
      ),
    );
  }
}
