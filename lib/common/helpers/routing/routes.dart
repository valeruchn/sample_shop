// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/common/helpers/routing/bottom_navigator/bottom.navigator.dart';
import 'package:sample_shop/screens/cart/cart.dart';
import 'package:sample_shop/screens/home_page/home_page.dart';
import 'package:sample_shop/screens/orders/order_details.dart';
import 'package:sample_shop/screens/orders/orders_log.dart';
import 'package:sample_shop/screens/product/product_details.dart';
import 'package:sample_shop/screens/profile/profile.dart';
import 'package:sample_shop/screens/settings/settings.dart';
import 'package:sample_shop/screens/auth/auth.dart';

final routes = RouteMap(routes: {
  '/': (route) => TabPage(
      child: BottomNavigator(), paths: const ['Home', 'Orders', 'Settings']),
  '/Home': (route) => const MaterialPage(child: HomePage()),
  '/Orders': (route) => const MaterialPage(child: OrdersLog()),
  '/Settings': (route) => const MaterialPage(child: Settings()),
  '/cart': (route) => MaterialPage(child: Cart()),
  '/auth': (route) => const MaterialPage(child: Auth()),
  '/profile': (route) => const MaterialPage(child: Profile()),
  '/product/:id': (route) => MaterialPage(
      child: ProductDetails(productId: route.pathParameters['id'] as String)),
  '/order/:id': (route) => MaterialPage(child: OrderDetails(orderId: route.pathParameters['id'] as String,)),
});
