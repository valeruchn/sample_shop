// Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/common/helpers/routing/routes.dart';
import 'package:sample_shop/common/styles/app_theme.dart';
import 'package:sample_shop/store/actions/auth.action.dart';
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
  const MyApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    // Проверка авторизации
    // _checkAuth();
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, bool>(
        onInit: (store) => _checkAuth(),
        converter: (store) => store.state.user.phone.isNotEmpty,
        builder: (context, isAuth) => MaterialApp.router(
          title: 'Flutter Demo',
          theme: appTheme,
          routerDelegate: RoutemasterDelegate(
              navigatorKey: navigatorStateKey,
              routesBuilder: (context) => createRoutes(isAuth)),
          routeInformationParser: const RoutemasterParser(),
        ),
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
