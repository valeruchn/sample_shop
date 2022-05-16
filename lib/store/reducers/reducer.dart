// Project imports:
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
import 'package:sample_shop/store/models/cart/cart.model.dart';
import 'package:sample_shop/store/models/categories/category.model.dart';
import 'package:sample_shop/store/models/notification/notification.model.dart';
import 'package:sample_shop/store/models/order/order.model.dart';
import 'package:sample_shop/store/models/products/product.model.dart';
import 'package:sample_shop/store/models/products/products.model.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/auth.reducer.dart';
import 'package:sample_shop/store/reducers/cart.reducer.dart';
import 'package:sample_shop/store/reducers/categories.reducer.dart';
import 'package:sample_shop/store/reducers/current_product.reducer.dart';
import 'package:sample_shop/store/reducers/home_page_title.reducer.dart';
import 'package:sample_shop/store/reducers/notification.reducer.dart';
import 'package:sample_shop/store/reducers/order.reducer.dart';
import 'package:sample_shop/store/reducers/products.reducer.dart';
import 'package:sample_shop/store/reducers/user.reducer.dart';

class AppState {
  AppState(
      {required this.auth,
      required this.user,
      required this.products,
      required this.currentProduct,
      required this.categories,
      required this.cart,
      required this.orders,
      required this.homePageTitle,
      required this.notification});

  AuthMobileModel auth;
  UserModel user;
  ProductsModel products;
  ProductModel? currentProduct;
  List<CategoryModel> categories;
  CartModel cart;
  OrderModel orders;
  String homePageTitle;
  NotificationModel? notification;
}

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
      auth: authReducer(state.auth, action),
      user: userReducer(state.user, action),
      products: productsReducer(state.products, action),
      currentProduct: currentProductReducer(state.currentProduct, action),
      categories: categoriesReducer(state.categories, action),
      cart: cartReducer(state.cart, action),
      orders: ordersReducer(state.orders, action),
      homePageTitle: homePageTitleReducer(state.homePageTitle, action),
      notification: notificationReducer(state.notification, action));
}
