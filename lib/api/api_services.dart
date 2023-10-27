import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_response.dart';

class ApiServices {
  final Dio _dio = Dio();

  ///final _authorizationKey = "Bearer ${ApiEndPoints.authToken}";

  ApiServices() {
    _dio.options.baseUrl = ApiEndPoints.baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<ApiResponse?> getRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      _dio.options.headers['Authorization'] =
      'Bearer ${ApiEndPoints.authToken}';
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse<T>.fromJson(response.data);
        return apiResponse;
      } else {
        log("something went wrong");
      }
    } catch (e) {
      log("error in catch");
      log(e.toString());
    }
    return null;
  }

  Future<ApiResponse?> postRequest<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      _dio.options.headers['Authorization'] =
          'Bearer ${ApiEndPoints.authToken}';
      final response = await _dio.post(endpoint,
          data: data, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse<T>.fromJson(response.data);
        return apiResponse;
      } else {
        log('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }

  void close() {
    _dio.close();
  }
}
