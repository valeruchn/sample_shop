import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/screens/order_confirmation/order_user_details.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // Отключение фокуса при клике за пределы поля
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text(kConfirmationOrderText),
            ),
            body:  SingleChildScrollView(
              reverse: true,
              child: StoreConnector<AppState, UserModel>(
                  converter: (store) => store.state.user,
                  builder: (context, user) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: OrderUserDetails(user: user)),
                ),
            ),
            ));
  }
}
