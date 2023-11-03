import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pizza/api/end_point.dart';

import '../widgets/common_dialog.dart';
import 'api_response.dart';

class ApiServices {
  final Dio _dio = Dio();

  ApiServices() {
    _dio.options.baseUrl = ApiEndPoints.baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';

    //_dio.interceptors.add(PrettyDioLogger());
  }

  ApiResponse apiResponse =
      ApiResponse(message: "Data Not Found", status: false, data: {});

  Future<ApiResponse> getRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParameters, String data = ""}) async {
    try {
      _dio.options.headers['Authorization'] =
          'Bearer ${ApiEndPoints.authToken}';
      final response = await _dio.get(endpoint + data,
          queryParameters: queryParameters, data: data);
     // log("response-->${response}");
      if (response.statusCode == 200) {
        apiResponse = ApiResponse<T>.fromJson(response.data);
        return apiResponse;
      }
    } catch (e) {
      handleError(e);
    }
    return apiResponse;
  }

  Future<ApiResponse> postRequest<T>(
    String endpoint, {
    String? data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      _dio.options.headers['Authorization'] =
          'Bearer ${ApiEndPoints.authToken}';

      final response = await _dio.post(endpoint,
          data: '"' + data.toString() + '"', queryParameters: queryParameters);

      if (response.statusCode == 200) {
        apiResponse = ApiResponse<T>.fromJson(response.data);
        return apiResponse;
      }
    } catch (e) {
      handleError(e);
    }
    return apiResponse;
  }

  void handleError(dynamic e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        showErrorDialog(
          title: "Network Error",
          message: "Check your internet connection and try again.",
        );
      } else {
        showErrorDialog(
          title: "Something Went Wrong !",
          message: "Please try again",
        );
      }
    } else {
      showErrorDialog(
        title: "Something Went Wrong !",
        message: "Please try again",
      );
    }
  }

  void close() {
    _dio.close();
  }
}
