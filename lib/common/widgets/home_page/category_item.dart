// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/models/categories/category.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({Key? key, required this.category}) : super(key: key);
  final CategoryModel category;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool _isOpenSubCatMenu = false;

  // Обработка нажатия на категорию
  // Аргументы: категория(обьект CategoryModel), функция, полученная из storeConverter
  // и подкатегория
  void _handleCategorySelect(
      CategoryModel catData,
      void Function({required String category, String? subcategory}) action,
      String? subcategory) {
    // Если это заголовок выпадающего меню, то переключаем режим отображения
    // подкатегорий
    if (catData.subcategories.isNotEmpty && subcategory == null) {
      _toggleSubCatMenu();
    } else {
      // иначе запрашиваем данные с api
      action(category: catData.category, subcategory: subcategory);
    }
  }

  // Открыть/закрыть подкатегории
  void _toggleSubCatMenu() {
    setState(() {
      _isOpenSubCatMenu = !_isOpenSubCatMenu;
    });
  }

  // Переключение фильтра storeConverter
  void Function(
      {required String category,
      String? subcategory}) _handleChangeFilterConverter(
          Store<AppState> store) =>
      ({required String category, String? subcategory}) {
        store.dispatch(
            GetProductsPending(category: category, subcategory: subcategory));
        Navigator.pop(context);
      };

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,
        void Function({required String category, String? subcategory})>(
      converter: _handleChangeFilterConverter,
      builder: (context, action) => Column(
        children: [
          // Выпадающее меню
          ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.circleDot,
                color: kPrimaryColor,
              ),
              title: Text(widget.category.title),
              onTap: () =>
                  _handleCategorySelect(widget.category, action, null)),
          if (_isOpenSubCatMenu)
            Column(
              children: [
                const Divider(
                  color: kDefaultBorderColor,
                  height: 0.00,
                ),
                ListTile(
                    leading: Container(
                      margin: const EdgeInsets.only(left: 15.00, top: 5.5),
                      child: const FaIcon(
                        FontAwesomeIcons.circleDot,
                        size: 12.00,
                        color: kPrimaryColor,
                      ),
                    ),
                    title: Container(
                        margin: const EdgeInsets.only(left: 10.00),
                        child: const Text(kAllCategoryTitleText)),
                    onTap: () =>
                        _handleCategorySelect(widget.category, action, '')),
                ...widget.category.subcategories
                    .map((subcategory) => ListTile(
                        leading: Container(
                          margin: const EdgeInsets.only(left: 15.00, top: 5.5),
                          child: const FaIcon(
                            FontAwesomeIcons.circleDot,
                            size: 12.00,
                            color: kPrimaryColor,
                          ),
                        ),
                        title: Container(
                            margin: const EdgeInsets.only(left: 10.00),
                            child: Text(subcategory.subcategory_title)),
                        onTap: () => _handleCategorySelect(
                            widget.category, action, subcategory.subcategory)))
                    .toList(),
                const Divider(
                  color: kDefaultBorderColor,
                  height: 0.00,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
