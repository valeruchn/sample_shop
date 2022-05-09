// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/common/localStorage/auth_token_storage_options.dart';
import 'package:sample_shop/store/actions/auth.action.dart';
import 'package:sample_shop/store/store.dart';

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
    },
      onError: (DioError e, ErrorInterceptorHandler handler) async {
        final bool isInternetConnection =
        await InternetConnectionChecker().hasConnection;
        if (!isInternetConnection) {
          print('dioerror: No internet connection.');
        }
        if (e.response?.statusCode == 401){
          print('dioerror: Not authorised');
        }
      }
    ));
  }

  final AuthTokenLocalStorage authTokenLocalStorage;
  final Dio dio = Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2',
      responseType: ResponseType.json,
      contentType: ContentType.json.toString()));
}
