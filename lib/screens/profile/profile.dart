// flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Project imports:
import 'package:sample_shop/common/services/auth.service.dart';
import 'package:sample_shop/common/widgets/profile/logout_confirmation_modal.dart';
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
        actions: [
          IconButton(onPressed: () {
            logoutConfirmation(context);
          }, icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket))
        ],
      ),
      body: Container(
        color: const Color(0xFF2A353A),
        width: double.infinity,
        height: double.maxFinite,
        padding: const EdgeInsets.all(10.00),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(bottom: 10.00),
                  child: Text(
                    'Особиста інформація',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 17.00),
                  )),
              StoreConnector<AppState, UserModel>(
                  converter: (store) => store.state.user,
                  builder: (context, user) => ProfileData(user: user)),
              // Container(
              //   margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       authService.logOut();
              //       Navigator.pop(context);
              //     },
              //     child: const Text('Вийти'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
