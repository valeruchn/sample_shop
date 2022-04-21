// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

//Project imports:
import 'package:sample_shop/store/actions/auth.action.dart';
import 'package:sample_shop/store/models/auth/firebase_auth_user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  // ключь для управления формой
  final _formKey = GlobalKey<FormState>();

  // форма ввода телефона
  final _phoneController = TextEditingController();

  // ввод из модального окна диалога
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('auth'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text(''),
            ),
            StoreConnector<AppState, AuthUserFromFirebase>(
              converter: (store) => store.state.auth,
              builder: (context, state) => Text(state.verificationId!)),
            TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Номер телефона',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите номер телефона';
                  }
                  return null;
                },
                controller: _phoneController),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: StoreConnector<AppState, dynamic>(
                // Отправляем номер для отправки кода
                converter: (store) => (String phone) =>
                    store.dispatch(SendSmsPending(phone: phone)),
                builder: (context, sendSms) => ElevatedButton(
                  onPressed: () {
                    final mobile = _phoneController.text.trim();
                    sendSms(mobile);
                    _checkSMS();
                  },
                  child: const Text('Отправить'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Когда отправлен код показываем модально окно с вводом кода
  void _checkSMS() {
    showDialog(
        context: context,
        // закрывает ли диалоговое окно нажатие на барьер
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text("Enter SMS Code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                StoreConnector<AppState, dynamic>(
                  converter: (store) {
                    return (String smsCode) {
                      // todo может быть такое, что не успеют обновиться данные после отправки кода
                      final verificationId = store.state.auth.verificationId!;
                      store.dispatch(CheckSmsPending(
                          smsCode: smsCode, verificationId: verificationId));
                    };
                  },
                  builder: (context, checkCode) => OutlinedButton(
                    child: const Text("Done"),
                    onPressed: () {
                      String smsCode = _codeController.text.trim();
                      checkCode(smsCode);
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ));
  }
}
