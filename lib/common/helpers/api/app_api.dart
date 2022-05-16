// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sample_shop/common/helpers/constants/connection.constants.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

// Project imports:
import 'package:sample_shop/common/localStorage/auth_token_storage_options.dart';
import 'package:sample_shop/store/actions/notification.action.dart';
import 'package:sample_shop/store/models/notification/notification.model.dart';
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
    }, onError: (DioError e, ErrorInterceptorHandler handler) async {
      final bool isInternetConnection =
          await InternetConnectionChecker().hasConnection;
      if (!isInternetConnection) {
        store.dispatch(IsNotification(
            notification: NotificationModel(
                type: NotificationType.error,
                message: kLostInternetConnectionError)));
      }
      if (e.response?.statusCode == 401) {
        print('dioerror: Not authorised');
      }
      if (e.type == DioErrorType.connectTimeout) {
        store.dispatch(IsNotification(
            notification: NotificationModel(
                type: NotificationType.error,
                message: kLostConnectionWithApiErrorText)));
      }
    }));
  }

  final AuthTokenLocalStorage authTokenLocalStorage;
  final Dio dio = Dio(BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: 5000,
      responseType: ResponseType.json,
      contentType: ContentType.json.toString()));
}
