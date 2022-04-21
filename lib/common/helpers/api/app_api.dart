// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';

final Dio api = Dio(
  BaseOptions(
    baseUrl: 'http://10.0.2.2',
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  )
);
