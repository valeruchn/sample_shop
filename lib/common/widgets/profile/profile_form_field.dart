// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';

class ProfileFormField extends StatelessWidget {
  const ProfileFormField(
      {Key? key,
      required this.controller,
      required this.isEditing,
      required this.label})
      : super(key: key);
  final TextEditingController controller;
  final bool isEditing;
  final String label;

  // Преобразование строки в DateTime
  DateTime? _dateParse(String dateString) {
    return dateString.isNotEmpty ? DateTime.parse(dateString).toUtc() : null;
  }

  // Выбор даты рождения пикер
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateParse(controller.text) ?? DateTime(2010),
        firstDate: DateTime(1900),
        lastDate: DateTime(2010));
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        readOnly: label == 'День народження',
        style: const TextStyle(color: kDefaultTextColor),
        controller: controller,
        enabled: isEditing,
        maxLength: 30,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: kDefaultLabelTextColor),
            border: const OutlineInputBorder(),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kDefaultBorderColor)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            // не отображать счетчик количества символов
            counterText: '',
            // todo доделать обновление состояния при редактировании поля
            suffixIcon: (isEditing && controller.text.isNotEmpty)
                ? IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: const Icon(Icons.clear),
                    onPressed: controller.clear,
                  )
                : null),
        onTap: label == 'День народження'
            ? () {
                if (isEditing) {
                  _selectDate(context);
                }
              }
            : null,
      ),
    );
  }
}
