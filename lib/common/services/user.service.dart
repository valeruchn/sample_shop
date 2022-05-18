// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:sample_shop/common/helpers/api/app_api.dart';
import 'package:sample_shop/common/helpers/utils/close_pin_code_modal.dart';
import 'package:sample_shop/store/models/user/user.model.dart';

// Запрос профиля пользователя
Future<UserModel> getUserProfile() async {
  try {
    final Response<dynamic> res =
        await api.dio.get<dynamic>('/users/get-user-profile');
    final Map<String, dynamic> user = res.data as Map<String, dynamic>;
    // закрытие модального окна с вводом пин кода, если оно открыто
    closePinCodeModal();
    return UserModel.fromJson(user);
  } catch (e) {
    print('error get user profile: $e');
  }
  return UserModel(phone: '');
}

// Обновление профиля пользователя
Future<UserModel> updateUserProfile(Map<String, dynamic> userData) async {
  try {
    final Response<dynamic> res = await api.dio
        .post<dynamic>('/users/update-user-profile', data: userData);
    final Map<String, dynamic> user = res.data as Map<String, dynamic>;
    return UserModel.fromJson(user);
  } catch (e) {
    print(e);
  }
  return null as UserModel;
}

// Добавить товар в избранное в профиль клиента
Future<List<String>> addProductToFavourites(String productId) async {
  try {
    final Response<dynamic> res =
        await api.dio.post('/users/add-product-to-favorite/$productId');
    final List<dynamic> favourites = res.data;
    return favourites.map((id) => id as String).toList();
  } catch (e) {
    print('error add to favourites: $e');
    return [];
  }
}

//  Удалить товар из избранного в профиле клиента
Future<List<String>> removeProductFromFavourites(String productId) async {
  try {
    final Response<dynamic> res =
        await api.dio.post('/users/remove-product-from-favorite/$productId');
    final List<dynamic> favourites = res.data;
    return favourites.map((id) => id as String).toList();
  } catch (e) {
    print('error add to favourites: $e');
    return [];
  }
}

// Запрос пользователей(админ)
// Future<List<UserModel>> getUsers() async {
//   try {
//     final Response<dynamic> res = await api.dio.get<dynamic>('/users');
//     final List<dynamic> users = res.data as List<dynamic>;
//     return users
//         .map<UserModel>((dynamic users) => UserModel.fromJson(users as Map<String, dynamic>))
//         .toList();
//   } catch (e) {
//     print(e);
//   }
//   return [];
