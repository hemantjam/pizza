import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../widgets/common_dialog.dart';
import 'api_response.dart';

class ApiServices {
  final Dio _dio = Dio();

  ApiServices() {
    _dio.options.baseUrl = ApiEndPoints.baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';

    _dio.interceptors.add(PrettyDioLogger(
        responseBody: false, responseHeader: true, requestBody: true));
  }

  /* ApiResponse apiResponse =
      ApiResponse(message: "Data Not Found", status: false, data: {});
*/
  Future<ApiResponse?> getRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParameters, String data = ""}) async {
    try {
      _dio.options.headers['Authorization'] =
          'Bearer ${ApiEndPoints.authToken}';
      final response = await _dio.get(endpoint + data,
          queryParameters: queryParameters, data: data);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse<T>.fromJson(response.data);
        return apiResponse;
      } else {
        showCoomonErrorDialog(
            title: "Error", message: response.statusMessage ?? "");
      }
    } catch (e) {
      log("error--->$endpoint");
      handleError(e);
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
          data: data ?? '"' + data + '"', queryParameters: queryParameters);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse<T>.fromJson(response.data);
        return apiResponse;
      } else {
        handleError({
          "status": response.statusCode!,
          "message": response.statusMessage ?? ""
        });
      }
    } catch (e) {
    //  handleError(e);
      log("error===>$endpoint");
    }
    return null;
  }

  void handleError(dynamic e) {
log("----->${e.toString()}");
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        showCoomonErrorDialog(
          title: "Network Error",
          message: "Check your internet connection and try again.",
        );
      }else if(e.type==DioExceptionType.badResponse){
        showCoomonErrorDialog(
          title: "Error:",
          message:e.response?.statusMessage ?? "Session e",
        );
      } else {
        showCoomonErrorDialog(
          title: "Something Went Wrong !!",
          message: e.response?.statusMessage ?? "",
        );
      }
    } else {
      log("error--->${e.error.toString()}");
      showCoomonErrorDialog(
        title: "Something Went Wrong !",
        message: e.message ?? "",
      );
    }
  }

  void close() {
    _dio.close();
  }
}
