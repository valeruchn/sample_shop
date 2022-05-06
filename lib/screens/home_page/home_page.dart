// Flutter imports:
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/widgets/home_page/menu_drawer.dart';
import 'package:sample_shop/common/widgets/home_page/search_panel.dart';
import 'package:sample_shop/screens/home_page/product_card.dart';
import 'package:sample_shop/store/actions/products.action.dart';

// Project imports:
import 'package:sample_shop/store/reducers/reducer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOpenSearch = false;

  // Заголовок екрана
  String _selectedTitle = kHomeScreenTitleText;

  // Выбор фавориты или все
  void Function() _handleSelectFavourites(Store<AppState> store) => () {
        if (_selectedTitle != kFavouriteCategoryTitleText) {
          handleChangeTitle(kFavouriteCategoryTitleText);
          store.dispatch(GetFavouriteProductsPending());
        } else {
          handleChangeTitle(kHomeScreenTitleText);
          store.dispatch(GetProductsPending());
        }
      };

  // изменение заголовка екрана
  void handleChangeTitle(String title) {
    setState(() {
      _selectedTitle = title;
    });
  }

  // Вывод иконки фаворит
  FaIcon favouriteIcon() {
    if (_selectedTitle == kFavouriteCategoryTitleText) {
      return const FaIcon(
        FontAwesomeIcons.solidHeart,
        size: 30.00,
      );
    } else {
      return const FaIcon(
        FontAwesomeIcons.heart,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Отключение фокуса при клике за пределы поля
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_selectedTitle),
          actions: [
            StoreConnector<AppState, void Function()>(
                converter: _handleSelectFavourites,
                builder: (context, handleSelectFavourite) => IconButton(
                    icon: favouriteIcon(), onPressed: handleSelectFavourite)),
            IconButton(
                onPressed: () {
                  setState(() {
                    _isOpenSearch = !_isOpenSearch;
                    // Изменение заголовка
                    if(_isOpenSearch){
                      _selectedTitle = kSearchPanelLabelText;
                    } else {
                      _selectedTitle = kHomeScreenTitleText;
                    }
                  });
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  // Открываем боковое меню
                  _scaffoldKey.currentState?.openEndDrawer();
                  // Отключаем фокус на поле ввода, если он был
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                icon: const Icon(Icons.menu)),
            IconButton(
              icon: Badge(
                badgeContent: StoreConnector<AppState, String>(
                    converter: (store) =>
                        store.state.cart.cartItems.length.toString(),
                    builder: (context, itemsCount) => Text(itemsCount)),
                child: const Icon(Icons.shopping_cart),
              ),
              tooltip: 'Open shopping cart',
              onPressed: () => Routemaster.of(context).push('/cart'),
            )
          ],
        ),
        endDrawer: MenuDrawer(handleChangeTitle: handleChangeTitle),
        // Для получения данных из стейт
        body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => Column(
            children: [
              if (_isOpenSearch) const SearchPanel(),
              Expanded(
                child: GridView.count(
                  // Отключает фокус и клавиатуру при скроле
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  primary: false,
                  padding: const EdgeInsets.all(7),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  // соотношение сторон ячеек грид сетки
                  childAspectRatio: (1 / 1.5),
                  children: state.products.isNotEmpty
                      ? [
                          ...state.products
                              .map((product) => ProductCard(
                                    id: product.id,
                                    title: product.title,
                                    property: product.property,
                                    weight: product.weight,
                                    description: product.description,
                                    photo: product.photo,
                                    category: product.category,
                                    price: product.price,
                                  ))
                              .toList(),
                        ]
                      : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
