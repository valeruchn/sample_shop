// Flutter imports:
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/widgets/home_page/menu_drawer.dart';
import 'package:sample_shop/common/widgets/home_page/search_panel.dart';
import 'package:sample_shop/screens/home_page/product_card.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/store.dart';
import 'package:sample_shop/common/widgets/home_page/get_products_listener.widget.dart';
import 'package:sample_shop/store/models/products/products.model.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOpenSearch = false;
  final TextEditingController searchController = TextEditingController();

  // Выбор фавориты или все
  Map<String, dynamic> _handleSelectFavourites(Store<AppState> store) {
    // Если пользователь в системе, запрашиваем фавориты
    // Если нет, перенаправляем на auth
    final bool isAuth = store.state.user.phone.isNotEmpty;
    void action() {
      if (!store.state.products.productsQuery.favourites) {
        store.dispatch(GetFavouriteProductsPending());
      } else {
        store.dispatch(ResetQueryFiltersPending());
      }
    }

    void redirectAction() {
      Routemaster.of(context).push('/auth');
    }

    return {
      'title': store.state.homePageTitle,
      'action': isAuth ? action : redirectAction
    };
  }

  // Вывод иконки фаворит
  FaIcon favouriteIcon(String selectedTitle) {
    if (selectedTitle == kFavouriteCategoryTitleText) {
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

  ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    // когда позиция скрола достигла последнего елемента
    // происходит запрос следующей страницы
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      store.dispatch(NextPageProductsPending());
    }
  }

  // Подписываемся на отслеживание скрола
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  // Отписываемся при размонтировании виджета
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Отключение фокуса при клике за пределы поля
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GetProductsListener(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: StoreConnector<AppState, String>(
              converter: (store) => store.state.homePageTitle,
              builder: (context, title) => Text(title),
            ),
            actions: [
              StoreConnector<AppState, Map<String, dynamic>>(
                  converter: _handleSelectFavourites,
                  builder: (context, handlerMap) => IconButton(
                      icon: favouriteIcon(handlerMap['title']),
                      onPressed: handlerMap['action'])),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isOpenSearch = !_isOpenSearch;
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
                onPressed: () => Routemaster.of(context).push('/cart'),
              )
            ],
          ),
          endDrawer: const MenuDrawer(),
          // Для получения данных из стейт
          body: StoreConnector<AppState, ProductsModel>(
            converter: (store) => store.state.products,
            builder: (context, state) => Column(
              children: [
                if (_isOpenSearch)
                  SearchPanel(searchController: searchController),
                Expanded(
                  child: GridView.count(
                    controller: _scrollController,
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
                    children: state.productsList.isNotEmpty
                        ? [
                            ...state.productsList
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
                if (state.productsQuery.isLoad)
                  const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
