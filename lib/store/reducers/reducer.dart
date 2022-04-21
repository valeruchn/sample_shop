// Project imports:
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
import 'package:sample_shop/store/models/cart/cart.model.dart';
import 'package:sample_shop/store/models/order/order.model.dart';
import 'package:sample_shop/store/models/product.model.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/auth.reducer.dart';
import 'package:sample_shop/store/reducers/cart.reducer.dart';
import 'package:sample_shop/store/reducers/order.reducer.dart';
import 'package:sample_shop/store/reducers/products.reducer.dart';
import 'package:sample_shop/store/reducers/user.reducer.dart';

class AppState {
  AppState({
    required this.auth,
    required this.user,
    required this.products,
    required this.cart,
    required this.orders
  });
  AuthUserFromFirebase auth;
  UserModel user;
  List<ProductModel> products;
  CartModel cart;
  OrderModel orders;
}

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    auth: authReducer(state.auth, action),
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action),
    cart: cartReducer(state.cart, action),
      orders: ordersReducer(state.orders, action)
  );
}
