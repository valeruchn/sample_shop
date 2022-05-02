// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/store/models/user/user.model.dart';

// Запрос профиля пользователя
Future<UserModel> getUserProfile() async {
  try {
    final Response<dynamic> res = await api.dio.get<dynamic>('/users/get-user-profile');
    final Map<String, dynamic> user = res.data as Map<String, dynamic>;
    return UserModel.fromJson(user);
  } catch (e) {
    print('error get user profile: $e');
  }
  return UserModel(phone: '');
}

// Создание учетной записи клиента
// Future<UserModel> registrationUser(Map<String, dynamic> userData) async {
//   try {
//     final Response<dynamic> res = await api.dio.post<dynamic>('/users/create', data: userData);
//     final Map<String, dynamic> user = res.data as Map<String, dynamic>;
//     return UserModel.fromJson(user);
//   } catch (e) {
//     print(e);
//   }
//   return null as UserModel;
// }

// Обновление профиля пользователя
Future<UserModel> updateUserProfile(Map<String, dynamic> userData) async {
  try {
    final Response<dynamic> res = await api.dio.post<dynamic>('/users/update-user-profile', data: userData);
    final Map<String, dynamic> user = res.data as Map<String, dynamic>;
    print(user);
    return UserModel.fromJson(user);
  } catch (e) {
    print(e);
  }
  return null as UserModel;
}

Future<List<UserModel>> getUsers() async {
  try {
    final Response<dynamic> res = await api.dio.get<dynamic>('/users');
    final List<dynamic> users = res.data as List<dynamic>;
    return users
        .map<UserModel>((dynamic users) => UserModel.fromJson(users as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print(e);
  }
  return [];
}
