// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

class OrderConfirmationFormField extends StatelessWidget {
  const OrderConfirmationFormField(
      {Key? key,
      required this.controller,
      required this.isEditing,
      required this.label,
      required this.isRequired,
      this.maxLength = 30,
      this.maxLines = 1})
      : super(key: key);

  final TextEditingController controller;
  final bool isEditing;
  final bool isRequired;
  final String label;
  final int? maxLength;
  final int? maxLines;

  // form validator
  String? _validator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$kInputLabelValidatorText $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: StatefulBuilder(
        builder: (context, setState) => TextFormField(
            style: const TextStyle(color: kDefaultTextColor),
            controller: controller,
            onChanged: (value) => setState(() {}),
            enabled: isEditing,
            maxLength: maxLength,
            maxLines: maxLines,
            validator: (value) => isRequired ? _validator(value, label) : null,
            decoration: InputDecoration(
                labelText: '$label${isRequired?'*':''}',
                labelStyle: const TextStyle(color: kDefaultLabelTextColor),
                border: const OutlineInputBorder(),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kDefaultBorderColor)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)),
                // не отображать счетчик количества символов
                counterText: '',
                suffixIcon: (isEditing && controller.text.isNotEmpty)
                    ? IconButton(
                        color: Theme.of(context).primaryColor,
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          setState(() {});
                        },
                      )
                    : null)),
      ),
    );
  }
}
