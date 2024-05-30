import 'package:dio/dio.dart';

class API {
  final String path;
  const API(this.path);
}

class ApiService {
  final Dio dio = Dio();

  @API('api/eshop/homepage')
  Future<Map<String, dynamic>> homepage({required String version}) async {
    final response = await dio.get(
        'https://mobileapiuat.citysuper.com.hk/public/api/eshop/homepage',
        queryParameters: {'version': version});
    return response.data;
  }
}
