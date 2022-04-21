// flutter imports:
import 'package:flutter/material.dart';
import 'package:sample_shop/common/services/auth.service.dart';

// Project imports:
import 'package:sample_shop/screens/profile/profile_data.dart';
import 'package:sample_shop/screens/settings/settings.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const ProfileData(),
            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AuthService().logOut();
                  Navigator.pop(context);
                },
                child: const Text('Выйти'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
