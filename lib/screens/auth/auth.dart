// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:routemaster/routemaster.dart';

//Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/widgets/auth/enter_sms.modal.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // ключь для управления формой
  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  String _phoneFieldValue = '';
  final _codeController = TextEditingController();
  bool _applyAgreements = true;
  bool _errorAgreement = false;
  bool wrongSmsCode = false;

  String? _verificationId;
  int? _forceResendingToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAuthScreenTitleText),
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
                child: const Text(kAuthGreetingTitleText,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0)),
              ),
              IntlPhoneField(
                  autovalidateMode: AutovalidateMode.disabled,
                  style: const TextStyle(color: kDefaultTextColor),
                  decoration: const InputDecoration(
                    labelText: kPhoneNumberFieldText,
                    labelStyle: TextStyle(color: kDefaultLabelTextColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDefaultBorderColor),
                    ),
                    counterText: '',
                  ),
                  initialCountryCode: 'UA',
                  onChanged: (phone) {
                    _phoneFieldValue = phone.completeNumber;
                  },
                  invalidNumberMessage: kIncorrectPhoneNumberText),
              Row(
                children: [
                  Checkbox(
                    side: const BorderSide(color: kPrimaryColor),
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
                  const Flexible(child: Text(kLicenceAgreementLabelText))
                ],
              ),
              if (_errorAgreement == true)
                Container(
                  margin: const EdgeInsets.only(left: 11.0),
                  child: const Text(
                    kIncorrectLicenceAgreementLabelText,
                    style: TextStyle(
                      color: kErrorFieldLabelColor,
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
                      final mobile = _phoneFieldValue.trim();
                      _authUser(mobile, context);
                    } else if (_applyAgreements == false) {
                      setState(() {
                        _errorAgreement = true;
                      });
                    }
                  },
                  child: const Text(kSendSmsCodeButtonText),
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
    // FirebaseAuth _auth = FirebaseAuth.instance;

    _firebaseAuth
        .verifyPhoneNumber(
            // телефон, полученый из формы
            phoneNumber: mobile,
            // Время, которое плагин будет ожидать до обработки
            timeout: const Duration(seconds: 60),
            // После успешной проверки кода
            verificationCompleted: (AuthCredential authCredential) {
              _firebaseAuth
                  .signInWithCredential(authCredential)
                  .catchError((e) {
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
    void _checkCode() {
      final _smsCode = _codeController.text.trim();
      // Готовим обьект для авторизации
      final _credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: _smsCode);
      // Закрываем форму
      _codeController.clear();
      _firebaseAuth.signInWithCredential(_credential).then((result) {
        if (result.user != null) {
          setState(() {
            wrongSmsCode = false;
          });
          Routemaster.of(context).pop();
        }
      }).catchError((e) {
        if (e.code == 'invalid-verification-id') {
          print('wrong sms');
          wrongSmsCode = true;
          setState(() {});
        }
      });
    }

    // Выводим модальное окно ввода пин кода
    showDialog(
        context: context,
        // закрывает ли диалоговое окно нажатие на барьер
        // barrierDismissible: false,
        builder: (context) => EnterSmsAuthModal(
            codeController: _codeController,
            action: _checkCode,
            wrongSmsCode: wrongSmsCode));
  }
}
