import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sample_shop/common/helpers/routing/bottom_navigator/bottom.navigator.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/store.dart';
//Package imports:
import 'package:firebase_auth/firebase_auth.dart';
//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  MyApp({required this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Запрос продуктов
    store.dispatch(GetProductsPending());
    // Проверка авторизации
    _checkAuth();
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomNavigator(),
      ),
    );
  }
  // Проверка авторизации
  void _checkAuth () {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        store.dispatch(RegistrationUserSuccess(user: UserModel(uid: '', phone: '')));
      } else {
        store.dispatch(RegistrationUserSuccess(user: UserModel(uid: user.uid, phone: user.phoneNumber ?? '')));
      }
    });
  }
}
