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
  const ProfileData({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  // ключь для управления формой
  final _formKey = GlobalKey<FormState>();

  // режим редактирования
  bool _isAllowEditing = false;

  // контроллеры формы
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _birthDayController = TextEditingController();

  // инициализация контроллеров
  @override
  void initState() {
    _initControllers();
    super.initState();
  }

  // Обновление состояния после авторизации
  @override
  void didUpdateWidget(ProfileData oldWidget) {
    if (widget.user != oldWidget.user) {
      _initControllers();
    }
    super.didUpdateWidget(oldWidget);
  }

  // инициализация контроллеров
  void _initControllers() {
    final String? birthDay = widget.user.birthdate is DateTime
        ? DateFormat('yyyy-MM-dd').format(widget.user.birthdate!)
        : null;
    _phoneController = TextEditingController(text: widget.user.phone);
    _nameController = TextEditingController(text: widget.user.firstName);
    _emailController = TextEditingController(text: widget.user.email);
    _birthDayController = TextEditingController(text: birthDay);
  }

  // Преобразование строки в DateTime
  DateTime? _dateParse(String dateString) {
    return dateString.isNotEmpty ? DateTime.parse(dateString).toUtc() : null;
  }

  // Выбор даты рождения пикер
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateParse(_birthDayController.text) ?? DateTime(2010),
        firstDate: DateTime(1900),
        lastDate: DateTime(2010));
    if (picked != null) {
      _birthDayController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // create userObject
  UserModel _createUserData() {
    return UserModel(
        firstName: _nameController.text,
        birthdate: _dateParse(_birthDayController.text),
        email: _emailController.text,
        phone: _phoneController.text);
  }

  // Переключение режима редактирования формы
  void _toggleAllowEditing() {
    setState(() {
      _isAllowEditing = !_isAllowEditing;
    });
  }

  // Отмена редактирования формы
  void _cancelEditing() {
    _formKey.currentState?.reset();
    setState(() {
      _isAllowEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: _cancelEditing, child: const Text('cancel')),
              ],
            ),
            TextFormField(
              controller: _nameController,
              enabled: _isAllowEditing,
              maxLength: 30,
              decoration: InputDecoration(
                  hintText: 'Имя',
                  // не отображать счетчик количества символов
                  counterText: '',
                  suffixIcon: _isAllowEditing && _nameController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _nameController.clear,
                        )
                      : null),
            ),
            TextFormField(
              enabled: false,
              controller: _phoneController,
              // initialValue: user.phone,
              decoration: const InputDecoration(
                hintText: 'Телефон',
              ),
            ),
            TextFormField(
              controller: _emailController,
              enabled: _isAllowEditing,
              maxLength: 30,
              decoration: InputDecoration(
                  hintText: 'Email',
                  counterText: '',
                  suffixIcon:
                      _isAllowEditing && _emailController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _emailController.clear,
                            )
                          : null),
            ),
            TextFormField(
              controller: _birthDayController,
              enabled: _isAllowEditing,
              readOnly: true,
              decoration: InputDecoration(
                  hintText: 'День рождения',
                  suffixIcon:
                      _isAllowEditing && _birthDayController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _birthDayController.clear,
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
  }
}
