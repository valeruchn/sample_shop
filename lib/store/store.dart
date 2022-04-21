// Package imports:
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

// Project imports:
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/store/epics/auth.epics.dart';
import 'package:sample_shop/store/epics/cart.epics.dart';
import 'package:sample_shop/store/epics/order.epics.dart';
import 'package:sample_shop/store/epics/products.epics.dart';
import 'package:sample_shop/store/epics/user.epics.dart';
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
import 'package:sample_shop/store/models/cart/cart.model.dart';
import 'package:sample_shop/store/models/order/order.model.dart';
import 'package:sample_shop/store/models/product.model.dart';
import 'package:sample_shop/store/models/user/user.model.dart';

AppState initialState = AppState(
    auth: AuthUserFromFirebase.init(),
    user: UserModel(
      uid: '',
      phone: '',
    ),
    products: <ProductModel>[],
    cart: CartModel(cartQueryParams: [], cartItems: [], totalPrice: 0),
    orders: OrderModel());

final Store<AppState> store = Store<AppState>(appStateReducer,
    initialState: initialState,
    middleware: <
        dynamic Function(Store<AppState>, dynamic, dynamic Function(dynamic))>[
      EpicMiddleware<dynamic>(getUserProfileEpic),
      EpicMiddleware<dynamic>(registrationUserEpic),
      EpicMiddleware<dynamic>(getProductsEpic),
      EpicMiddleware<dynamic>(getCartEpic),
      EpicMiddleware<dynamic>(addToCartEpic),
      EpicMiddleware<dynamic>(deleteFromCartEpic),
      EpicMiddleware<dynamic>(decrementItemFromCartEpic),
      EpicMiddleware<dynamic>(authSendSmsEpic),
      EpicMiddleware<dynamic>(authCheckSmsEpic),
      EpicMiddleware<dynamic>(updateUserProfileEpic),
      EpicMiddleware<dynamic>(createOrderEpic),
    ]);
