//Package imports:
import 'package:firebase_auth/firebase_auth.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/common/helpers/routing/routes.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/store.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Запрос продуктов
    store.dispatch(GetProductsPending());
    // Проверка авторизации
    _checkAuth();
    return StoreProvider(
      store: store,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
        store.dispatch(
            RegistrationUserSuccess(user: UserModel(uid: '', phone: '')));
      } else {
        store.dispatch(RegistrationUserSuccess(
            user: UserModel(uid: user.uid, phone: user.phoneNumber ?? '')));
      }
    });
  }
}
