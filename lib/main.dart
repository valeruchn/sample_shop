// Flutter imports:
//Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/common/helpers/routing/routes.dart';
import 'package:sample_shop/store/actions/auth.action.dart';
import 'package:sample_shop/store/actions/cart.action.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/store.dart';

//firebase
import 'firebase_options.dart';

void main() async {
  //firebase connection
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    //firebase connection
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    // Запрос продуктов
    store.dispatch(GetProductsPending());
    // Запрос корзины
    store.dispatch(GetCartPending());
    // Проверка авторизации
    _checkAuth();
    return StoreProvider(
      store: store,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 24, color: Colors.white),
            // displayLarge: TextStyle(fontSize: 15),
            // displayMedium: TextStyle(fontSize: 15),
            // displaySmall: TextStyle(fontSize: 15),
          ),
          primarySwatch: Colors.deepOrange,
        ),
        routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
        routeInformationParser: const RoutemasterParser(),
      ),
    );
  }

  // Проверка авторизации
  void _checkAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        store.dispatch(UnauthorizedUser());
      } else {
        store.dispatch(
            GetUserTokenPending(uid: user.uid, phone: user.phoneNumber ?? ''));
      }
    });
  }
}
