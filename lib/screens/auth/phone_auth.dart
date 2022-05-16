import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/services/auth.service.dart';
import 'package:sample_shop/common/widgets/auth/auth_state_listener_widget.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final _formKey = GlobalKey<FormState>();
  String _phoneFieldValue = '';
  bool _applyAgreements = true;
  bool _errorAgreement = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAuthScreenTitleText),
      ),
      body: AuthStateListener(
        child: Container(
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
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16.0)),
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
                        authService.signInWithPhoneSendSms(mobile);
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
      ),
    );
  }
}
