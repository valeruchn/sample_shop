// flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:routemaster/routemaster.dart';
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
      appBar: AppBar(title: const Text('Додатково')),
      body: StoreConnector<AppState, UserModel>(
          converter: (store) => store.state.user,
          builder: (context, user) => Container(
                color: const Color(0xFF2A353A),
                width: double.infinity,
                child: GridView.count(
                  padding: const EdgeInsets.all(15),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                  // соотношение сторон ячеек грид сетки
                  // childAspectRatio: (1 / 1.5),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF252F33),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(1, 3))
                          ]),
                      child: TextButton(
                          onPressed: () {
                            Routemaster.of(context).push('/profile');
                          },
                          child: const Text('Профіль')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF252F33),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(1, 3))
                          ]),
                      child: TextButton(
                          onPressed: () {}, child: const Text('Контакти')),
                    )
                  ],
                ),
              )),
    );
  }
}
