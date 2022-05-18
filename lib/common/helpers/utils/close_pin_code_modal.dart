import 'package:flutter/material.dart';
import 'package:sample_shop/common/widgets/auth/check_sms_modal.dart';

void closePinCodeModal() {
  if (pinCodeModalGlobalKey.currentContext != null) {
    Navigator.of(pinCodeModalGlobalKey.currentContext!, rootNavigator: true)
        .pop();
  }
}
