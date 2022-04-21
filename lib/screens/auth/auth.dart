// Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// Project imports:
import 'package:sample_shop/screens/profile/profile.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // ключь для управления формой
  final _formKey = GlobalKey<FormState>();
  String _phoneController = '';
  final _codeController = TextEditingController();
  int? _forceResendingToken;
  bool _applyAgreements = true;
  bool _errorAgreement = false;
  String? _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Авторизация',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    'Для входа или регистрации введите номер телефона',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0)),
              ),
              IntlPhoneField(
                  autovalidateMode: AutovalidateMode.disabled,
                  decoration: const InputDecoration(
                    labelText: 'Номер телефона',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    counterText: '',
                  ),
                  initialCountryCode: 'UA',
                  onChanged: (phone) {
                    _phoneController = phone.completeNumber;
                  },
                  invalidNumberMessage: 'Некорректный номер телефона'),
              Row(
                children: [
                  Checkbox(
                    value: _applyAgreements,
                    onChanged: (bool? value) {
                      if (value == true) {
                        setState(() {
                          _errorAgreement = false;
                        });
                      }
                      setState(() {
                        _applyAgreements = value!;
                      });
                    },
                  ),
                  const Flexible(
                      child: Text(
                          'Нажимая кнопку отправить я принимаю условия политики конфиденциальности'))
                ],
              ),
              if (_errorAgreement == true)
                Container(
                  margin: const EdgeInsets.only(left: 11.0),
                  child: const Text(
                    'Примите условия',
                    style: TextStyle(
                      color: Color(0xFFD84B4B),
                      fontSize: 12.0,
                    ),
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                // По ширине екрана
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    var _state = _formKey.currentState!;
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_state.validate() && _applyAgreements == true) {
                      final mobile = _phoneController.trim();
                      _authUser(mobile, context);
                    } else if (_applyAgreements == false) {
                      setState(() {
                        _errorAgreement = true;
                      });
                    }
                  },
                  child: const Text('Отправить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _authUser(String mobile, BuildContext context) async {
    // Авторизация firebase
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth
        .verifyPhoneNumber(
            // телефон, полученый из формы
            phoneNumber: mobile,
            // Время, которое плагин будет ожидать до обработки
            timeout: const Duration(seconds: 60),
            // После успешной проверки кода
            verificationCompleted: (AuthCredential authCredential) {
              _auth.signInWithCredential(authCredential).catchError((e) {
                print(e);
              });
            },
            // При ошибках проверки кода
            verificationFailed: (FirebaseAuthException authException) {
              print(authException.message);
            },
            // Когда код отправлен
            codeSent: _onCodeSend,
            // Токен для повторной отправки, если он указан, то при
            // повторном нажатии отправить смс, будет повторно выслан тот же код
            forceResendingToken: _forceResendingToken,
            // Действие, после истечения срока таймаута
            codeAutoRetrievalTimeout: (String verificationId) {
              _verificationId = verificationId;
            })
        .catchError((e) {
      print(e);
    });
  }

  // Когда отправлен код показываем модально окно с вводом кода
  void _onCodeSend(String verificationId,
      int? forceResendingToken /*токен для повторной отправки*/) {
    // устанавливаем токен для возможности повторной отпраки
    _forceResendingToken = forceResendingToken;
    _verificationId = verificationId;
    // Віводим модальное окно ввода пин кода
    showDialog(
        context: context,
        // закрывает ли диалоговое окно нажатие на барьер
        // barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text("Enter SMS Code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                StoreConnector<AppState, dynamic>(
                  converter: (store) => (UserModel user) =>
                      store.dispatch(RegistrationUserPending(user: user)),
                  builder: (context, saveUser) => OutlinedButton(
                    child: const Text("Отправить"),
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      String _smsCode = _codeController.text.trim();
                      // отовим обьект для авторизации
                      PhoneAuthCredential _credential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: _smsCode);
                      // Закрываем форму
                      _codeController.clear();
                      auth.signInWithCredential(_credential).then((result) {
                        if (result.user != null) {
                          // Закрываем модальное окно, удаляем маршрут Auth и ушим маршрут
                          // Profile. При нажатии назад откроется Settings
                          // Оператор .. вызов нескольких методов одного и того же объекта
                          // .. помогает вызывать ряд методов, которые не обязательно возвращают объект.
                          Navigator.of(context)..pop()..pop()..push(
                              MaterialPageRoute(
                                  builder: (context) => const Profile()));
                        }
                      }).catchError((e) {
                        print('error: $e');
                      });
                    },
                  ),
                )
              ],
            ));
  }
}
