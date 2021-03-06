// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/common/helpers/routing/bottom_navigator/bottom.navigator.dart';
import 'package:sample_shop/screens/auth/auth.dart';
import 'package:sample_shop/screens/cart/cart.dart';
import 'package:sample_shop/screens/home_page/home_page.dart';
import 'package:sample_shop/screens/order_confirmation/new_order_details.dart';
import 'package:sample_shop/screens/order_confirmation/order_confirmation.dart';
import 'package:sample_shop/screens/orders/order_log_details.dart';
import 'package:sample_shop/screens/orders/orders_log.dart';
import 'package:sample_shop/screens/product/product_details.dart';
import 'package:sample_shop/screens/profile/profile.dart';
import 'package:sample_shop/screens/settings/settings.dart';

RouteMap createRoutes(bool isAuth) {
  return RouteMap(routes: {
    '/': (route) => TabPage(
        child: BottomNavigator(), paths: const ['Home', 'Orders', 'Settings']),
    '/Home': (route) => const MaterialPage(child: HomePage()),
    '/Orders': (route) =>
        MaterialPage(child: isAuth ? const OrdersLog() : const Auth()),
    '/Settings': (route) => const MaterialPage(child: Settings()),
    '/cart': (route) => const MaterialPage(child: Cart()),
    '/cart/order-confirmation': (route) =>
        MaterialPage(child: isAuth ? const OrderConfirmation() : const Auth()),
    '/cart/product/:id': (route) => MaterialPage(
        child: ProductDetails(productId: route.pathParameters['id'] as String)),
    '/new-order': (route) => const MaterialPage(child: NewOrder()),
    '/auth': (route) =>
        MaterialPage(child: !isAuth ? const Auth() : const Profile()),
    '/profile': (route) =>
        MaterialPage(child: isAuth ? const Profile() : const Auth()),
    '/product/:id': (route) => MaterialPage(
        child: ProductDetails(productId: route.pathParameters['id'] as String)),
    '/order/:id': (route) => MaterialPage(
        child: isAuth
            ? OrderLogDetails(
                orderId: route.pathParameters['id'] as String,
              )
            : const Auth()),
  });
}

// final routes = RouteMap(routes: {
//   '/': (route) => TabPage(
//       child: BottomNavigator(), paths: const ['Home', 'Orders', 'Settings']),
//   '/Home': (route) => const MaterialPage(child: HomePage()),
//   '/Orders': (route) => const MaterialPage(child: OrdersLog()),
//   '/Settings': (route) => const MaterialPage(child: Settings()),
//   '/cart': (route) => MaterialPage(child: Cart()),
//   '/auth': (route) => const MaterialPage(child: Auth()),
//   '/profile': (route) => const MaterialPage(child: Profile()),
//   '/product/:id': (route) => MaterialPage(
//       child: ProductDetails(productId: route.pathParameters['id'] as String)),
//   '/order/:id': (route) => MaterialPage(
//           child: OrderDetails(
//         orderId: route.pathParameters['id'] as String,
//       )),
// });
