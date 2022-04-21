// flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/screens/auth/auth.dart';
import 'package:sample_shop/screens/profile/profile.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: StoreConnector<AppState, UserModel>(
          converter: (store) => store.state.user,
          builder: (context, user) => Column(
                children: [
                  TextButton(
                      onPressed: () {
                        if (user.uid.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Auth()));
                        }
                      },
                      child: const Text('Профиль'))
                ],
              )),
    );
  }
}
