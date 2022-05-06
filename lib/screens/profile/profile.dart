// flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:sample_shop/common/widgets/modals/logout_confirmation_modal.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/screens/profile/profile_data.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kProfileScreenTitleText),
        actions: [
          IconButton(
              onPressed: () {
                logoutConfirmationModal(context: context);
              },
              icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket))
        ],
      ),
      body: Container(
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
                    kPersonalInfoText,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 17.00),
                  )),
              StoreConnector<AppState, UserModel>(
                  converter: (store) => store.state.user,
                  builder: (context, user) => ProfileData(user: user)),
            ],
          ),
        ),
      ),
    );
  }
}
