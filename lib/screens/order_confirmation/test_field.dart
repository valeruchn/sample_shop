import 'package:flutter/material.dart';
import 'package:sample_shop/screens/order_confirmation/formOrderControlProvider.dart';

class TestField extends StatelessWidget {
  const TestField({Key? key}) : super(key: key);
  // form validator
  String? _validator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Введите $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: const Text('Контактные данные')),
        TextFormField(
          maxLength: 30,
          onChanged: (value) =>
              FormOrderControlProvider.of(context)?.firstName = value,
          initialValue: FormOrderControlProvider.of(context)?.firstName,
          decoration: const InputDecoration(
            hintText: 'Имя',
            // не отображать счетчик количества символов
            counterText: '',
          ),
          validator: (value) => _validator(value, 'имя'),
        ),
        TextFormField(
          enabled: false,
          // initialValue: user.phone,
          decoration: const InputDecoration(
            hintText: 'Телефон',
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: const Text('Адрес')),
        TextFormField(
          maxLength: 30,
          onChanged: (value) =>
              FormOrderControlProvider.of(context)?.street = value,
          decoration: const InputDecoration(
            hintText: 'Улица',
            // не отображать счетчик количества символов
            counterText: '',
          ),
          validator: (value) => _validator(value, 'название улицы'),
        ),
        TextFormField(
          maxLength: 30,
          onChanged: (value) =>
              FormOrderControlProvider.of(context)?.houseNumber = value,
          decoration: const InputDecoration(
            hintText: 'Дом',
            // не отображать счетчик количества символов
            counterText: '',
          ),
          validator: (value) => _validator(value, 'номер дома'),
        ),
        TextFormField(
          maxLength: 30,
          onChanged: (value) =>
              FormOrderControlProvider.of(context)?.flat = value,
          decoration: const InputDecoration(
            hintText: 'Квартира',
            // не отображать счетчик количества символов
            counterText: '',
          ),
        ),
      ],
    );
  }
}
