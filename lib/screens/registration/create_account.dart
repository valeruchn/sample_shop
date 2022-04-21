// // Flutter imports:
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:sample_shop/store/actions/user.action.dart';
// import 'package:sample_shop/store/models/user/address.model.dart';
// import 'package:sample_shop/store/models/user/user.model.dart';
// import 'package:sample_shop/store/reducers/reducer.dart';
// //Project imports:
//
// class CreateOrder extends StatefulWidget {
//   const CreateOrder({Key? key}) : super(key: key);
//
//   @override
//   State<CreateOrder> createState() => _CreateOrderState();
// }
//
// class _CreateOrderState extends State<CreateOrder> {
//   final _formKey = GlobalKey<FormState>();
//   String _firstName = '';
//   String _lastName = '';
//   String _phone = '';
//   String _email = '';
//   DateTime _birthdate = DateTime.now();
//   String _street = '';
//   String _houseNumber = '';
//   String _flat = '';
//
//   UserModel userRegistration(
//       String firstName,
//       String lastName,
//       String phone,
//       String email,
//       DateTime birthdate,
//       String street,
//       String houseNumber,
//       String flat) {
//     final user = UserModel(
//         firstName: firstName,
//         lastName: lastName,
//         phone: phone,
//         email: email,
//         birthdate: birthdate,
//         address:
//             AddressModel(street: street, houseNumber: houseNumber, flat: flat));
//     return user;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User data'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(15),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(top: 10, bottom: 10),
//                 child: const Text('Данные пользователя:'),
//               ),
//               TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'Имя',
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Введите имя';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _firstName = value!;
//                   }),
//               TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'Фамилия',
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Введите фамилию';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _lastName = value!;
//                   }),
//               TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'Номер телефона',
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Введите номер телефона';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _phone = value!;
//                   }),
//               TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'Email',
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Введите Email';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _email = value!;
//                   }),
//               InputDatePickerFormField(
//                 firstDate: DateTime(1930),
//                 lastDate: DateTime(2010),
//                 onDateSaved: (date) {
//                   _birthdate = date;
//                 },
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 50, bottom: 10),
//                 child: const Text('Адрес:'),
//               ),
//               TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'Улица',
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Введите название улицы';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _street = value!;
//                   }),
//               TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'Дом',
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Введите номер дома';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _houseNumber = value!;
//                   }),
//               TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'Квартира',
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Введите номер квартиры';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _flat = value!;
//                   }),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: StoreConnector<AppState, dynamic>(
//                   converter: (store) => store,
//                   builder: (context, store) => ElevatedButton(
//                     onPressed: () {
//                       var _state = _formKey.currentState!;
//                       // Validate returns true if the form is valid, or false otherwise.
//                       if (_state.validate()) {
//                         _state.save();
//                         store.dispatch(RegistrationUserPending(
//                             user: userRegistration(
//                                 _firstName,
//                                 _lastName,
//                                 _phone,
//                                 _email,
//                                 _birthdate,
//                                 _street,
//                                 _houseNumber,
//                                 _flat)));
//                       }
//                     },
//                     child: const Text('Отправить'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
