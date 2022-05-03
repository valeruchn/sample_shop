// flutter imports:
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample_shop/common/widgets/profile/profile_form_actions.dart';
import 'package:sample_shop/common/widgets/profile/profile_form_field.dart';

// Project imports:
import 'package:sample_shop/store/models/user/user.model.dart';

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
    return Container(
      padding: const EdgeInsets.all(10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1.0, color: const Color(0xFF933D23))),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Actions
              ProfileFormActions(
                  isAllowEditing: _isAllowEditing,
                  toggleAllowEditing: _toggleAllowEditing,
                  createUserData: _createUserData,
                  cancelEditing: _cancelEditing),
              // Fields
              ProfileFormField(
                controller: _nameController,
                isEditing: _isAllowEditing,
                label: "Ім'я",
              ),
              ProfileFormField(
                controller: _phoneController,
                isEditing: false,
                label: 'Телефон',
              ),
              ProfileFormField(
                controller: _emailController,
                isEditing: _isAllowEditing,
                label: 'Email',
              ),
              ProfileFormField(
                controller: _birthDayController,
                isEditing: _isAllowEditing,
                label: 'День народження',
              ),
            ],
          )),
    );
  }
}
