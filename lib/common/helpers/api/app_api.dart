// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:sample_shop/common/localStorage/auth_token_storage_options.dart';

final api = AppApi(authTokenLocalStorage);

class AppApi {
  AppApi(this.authTokenLocalStorage) {
    dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      String token = await authTokenLocalStorage.getTokenFromLocalStorage();
      if (token.isNotEmpty) {
        options.headers["Authorization"] = 'Bearer $token';
      }
      return handler.next(options);
    }));
  }

  final AuthTokenLocalStorage authTokenLocalStorage;
  final Dio dio = Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2',
      responseType: ResponseType.json,
      contentType: ContentType.json.toString()));
}
