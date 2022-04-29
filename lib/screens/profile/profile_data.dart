// flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:sample_shop/store/actions/user.action.dart';

// Project imports:
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  // ключь для управления формой
  final _formKey = GlobalKey<FormState>();
  bool _isAllowEditing = false;

  void _toggleAllowEditing() {
    setState(() {
      _isAllowEditing = !_isAllowEditing;
    });
  }

  void _cancelEditing() {
    _formKey.currentState?.reset();
    setState(() {
      _isAllowEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserModel>(
      onInit: (store) =>
          store.dispatch(GetUserProfilePending(id: store.state.user.uid)),
      converter: (store) => store.state.user,
      builder: (context, user) {
        //form fields:
        final String? birthDay = user.birthdate is DateTime
            ? DateFormat('yyyy-MM-dd').format(user.birthdate!)
            : null;
        final TextEditingController _name =
            TextEditingController(text: user.firstName);
        final TextEditingController _email =
            TextEditingController(text: user.email);
        final TextEditingController _birthday =
            TextEditingController(text: birthDay);
        // dateTime picker
        Future<void> _selectDate(BuildContext context) async {
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: user.birthdate ?? DateTime(2010),
              firstDate: DateTime(1900),
              lastDate: DateTime(2010));
          if (picked != null && picked != user.birthdate) {
            _birthday.text = DateFormat('yyyy-MM-dd').format(picked);
            // DateTime date = DateTime.parse(_birthday.text);
          }
        }

        // create userObject
        UserModel _createUserData() {
          return UserModel(
              firstName: _name.text,
              birthdate: _birthday.text.isNotEmpty
                  ? DateTime.parse(_birthday.text).toUtc()
                  : null,
              email: _email.text,
              phone: user.phone,
              uid: user.uid);
        }

        // form
        return Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!_isAllowEditing)
                      TextButton(
                          onPressed: _toggleAllowEditing,
                          child: const Text('edit')),
                    if (_isAllowEditing)
                      StoreConnector<AppState, dynamic>(
                          converter: (store) => (UserModel user) =>
                              store.dispatch(UpdateProfilePending(user: user)),
                          builder: (context, updateProfile) => TextButton(
                              onPressed: () {
                                updateProfile(_createUserData());
                                _toggleAllowEditing();
                              },
                              child: const Text('save'))),
                    if (_isAllowEditing)
                      TextButton(
                          onPressed: _cancelEditing,
                          child: const Text('cancel')),
                  ],
                ),
                TextFormField(
                  controller: _name,
                  enabled: _isAllowEditing,
                  maxLength: 30,
                  decoration: InputDecoration(
                      hintText: 'Имя',
                      // не отображать счетчик количества символов
                      counterText: '',
                      suffixIcon: _isAllowEditing && _name.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _name.clear,
                            )
                          : null),
                ),
                TextFormField(
                  enabled: false,
                  initialValue: user.phone,
                  decoration: const InputDecoration(
                    hintText: 'Телефон',
                  ),
                ),
                TextFormField(
                  controller: _email,
                  enabled: _isAllowEditing,
                  maxLength: 30,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      counterText: '',
                      suffixIcon: _isAllowEditing && _name.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _email.clear,
                            )
                          : null),
                ),
                TextFormField(
                  controller: _birthday,
                  enabled: _isAllowEditing,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'День рождения',
                      suffixIcon: _isAllowEditing && _name.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _birthday.clear,
                            )
                          : null),
                  onTap: () {
                    if (_isAllowEditing) {
                      _selectDate(context);
                    }
                  },
                )
              ],
            ));
      },
    );
  }
}
