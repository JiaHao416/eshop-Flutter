import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_app/services/api_home.dart';
import '../model/api_login.dart';
import 'dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();
  late Dio _dio;

  ApiService() {
    _dio = _dioClient.dio;
  }

  @API('api/eshop/homepage', HttpMethod.GET)
  Future<HomePageResponse> homepage({required String version}) async {
    final response = await _dio
        .get('api/eshop/homepage', queryParameters: {'version': version});
    return HomePageResponse.fromJson(response.data);
  }

  @API('api/members/login', HttpMethod.POST)
  Future<LoginResponse> login(LoginRequest request) async {
    final response =
        await _dio.post('api/members/login', data: request.toJson());
    return LoginResponse.fromJson(response.data);
  }
}
