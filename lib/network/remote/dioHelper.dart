import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.escuelajs.co/api/',
        receiveDataWhenStatusError: true,
        // connectTimeout: const Duration(seconds: 10),
        // receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
  }) async {
    return dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(
        headers: {
          'Authorization': token ?? '',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    return dio.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}
