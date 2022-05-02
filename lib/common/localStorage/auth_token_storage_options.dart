// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

AuthTokenLocalStorage authTokenLocalStorage = AuthTokenLocalStorage();

class AuthTokenLocalStorage {
  // Получение токена из локального хранилища
  Future<String> getTokenFromLocalStorage() async {
    // Подключаемся к хранилищу
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      return token;
    }
    return '';
  }

  // Запись токена в локальное хранилище
  Future<void> addTokenToLocalStorage(String token) async {
    // Подключаемся к хранилищу
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

// Удаление токена из хранилища
  Future<void> deleteTokenFromLocalStorage() async {
    // Подключаемся к хранилищу
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
