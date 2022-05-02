// flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/services/auth.service.dart';

// Project imports:
import 'package:sample_shop/screens/profile/profile_data.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профіль'),
      ),
      body: Container(
        color: const Color(0xFF2A353A),
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StoreConnector<AppState, UserModel>(
              converter: (store) => store.state.user,
                builder: (context, user) => ProfileData(user: user)
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  authService.logOut();
                  Navigator.pop(context);
                },
                child: const Text('Вийти'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
