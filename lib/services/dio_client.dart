// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:dio/dio.dart';
import '../util/constant.dart';

enum HttpMethod { GET, POST, PUT, DELETE }

class API {
  final String path;
  final HttpMethod method;

  const API(this.path, this.method);
}

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.apiBaseUrl,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Platform': Constants.platform,
      'App-Version': Constants.appVersion,
    },
  ));

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer ${HelperUtil.getToken()}';
        options.headers['locale'] = getLocale();
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;

  String getLocale() {
    return 'en'; // Example locale
  }
}

class HelperUtil {
  static String getToken() {
    return '';
  }
}
