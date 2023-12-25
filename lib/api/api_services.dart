import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/utils/log.dart';
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
        responseBody: true, responseHeader: true, requestBody: true));
  }

  /* ApiResponse apiResponse =
      ApiResponse(message: "Data Not Found", status: false, data: {});
*/
  Future<ApiResponse?> getRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParameters, String data = ""}) async {
    Map<String, dynamic> logField = {
      "endpoint": endpoint,
      "queryParameters": queryParameters,
      "data": data
    };
    try {
      _dio.options.headers['Authorization'] =
          'Bearer ${ApiEndPoints.authToken}';
      final response = await _dio.get(endpoint + data,
          queryParameters: queryParameters, data: data);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse<T>.fromJson(response.data);
        logField.addAll({"response": response.toString()});
        AppLogs.add(logField.toString());
        return apiResponse;
      } else {
        showCoomonErrorDialog(
            title: "Error", message: response.statusMessage ?? "");
        logField.addAll({"error": "error in status code"});
        AppLogs.add(logField.toString());
      }
    } catch (e) {
      logField.addAll({"error": e});
      AppLogs.add(logField.toString());
      handleError(e);
    }
    return null;
  }

  Future<ApiResponse?> putRequest<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        String? token,
      }) async {
    Map<String, dynamic> logField = {
      "endpoint": endpoint,
      "queryParameters": queryParameters,
      "data": data
    };
    try {
      _dio.options.headers['Authorization'] =
      'Bearer ${ApiEndPoints.authToken}';

      final response = await _dio.put(endpoint,
          data: data ?? '"' + data + '"', queryParameters: queryParameters);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse<T>.fromJson(response.data);
        if (apiResponse.status) {
          return apiResponse;
        } else if (!apiResponse.status) {
          showCoomonErrorDialog(
              title: "Something went wrong", message: apiResponse.message);
        }
        logField.addAll({"response": response.toString()});
        AppLogs.add(logField.toString());
      } else {
        handleError({"status": "Error", "message": response.data["message"]});
        logField.addAll({"error": "error in response code"});
        AppLogs.add(logField.toString());
      }
    } catch (e) {
      logField.addAll({"error": e.toString()});
      AppLogs.add(logField.toString());
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
    Map<String, dynamic> logField = {
      "endpoint": endpoint,
      "queryParameters": queryParameters,
      "data": data
    };
    try {
      _dio.options.headers['Authorization'] =
          'Bearer ${ApiEndPoints.authToken}';

      final response = await _dio.post(endpoint,
          data: data ?? '"' + data + '"', queryParameters: queryParameters);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse<T>.fromJson(response.data);
        if (apiResponse.status) {
          return apiResponse;
        } else if (!apiResponse.status) {
          showCoomonErrorDialog(
              title: "Something went wrong", message: apiResponse.message);
        }
        logField.addAll({"response": response.toString()});
        AppLogs.add(logField.toString());
      } else {
        handleError({"status": "Error", "message": response.data["message"]});
        logField.addAll({"error": "error in response code"});
        AppLogs.add(logField.toString());
      }
    } catch (e) {
      logField.addAll({"error": e.toString()});
      AppLogs.add(logField.toString());
      handleError(e);
    }
    return null;
  }

  void handleError(dynamic e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        showCoomonErrorDialog(
          title: "Network Error",
          message: "Check your internet connection and try again.",
        );
      } else if (e.type == DioExceptionType.badResponse) {
        log("===>${e.toString()}");
        e.response?.statusCode == 401
            ? showCoomonErrorDialog(
                title: "Error:",
                message: e.response?.statusCode == 401
                    ? e.response!.data["error"]
                    : e.response!.data["message"],
              )
            : showCoomonErrorDialog(
                title: "Error",
                message: "Something went wrong",
              );
      } else {
        showCoomonErrorDialog(
          title: "Something went wrong:",
          message: e.response?.statusCode == 401
              ? e.response!.data["error"]
              : e.response!.data["message"],
        );
      }
    }
  }
}
