import 'dart:developer';

import 'package:dio/dio.dart';

import 'api_response.dart';

class ApiClient {
  final Dio dio = Dio();
  final baseUrl = 'https://tomcat.harvices.com/POSLocalAPI/';
  final authorizationKey =
      "Bearer 91KJpxThaD3FEGOTrxhjGVO29utKrpjzwjHZb8HhaagLTKLoVU/pCfzARQggGfdq/uVFeyicu4SHs36LJhYMuJpqkxBx7POM3x+ReTQ25lz9nZDE9qa0GU2gXtIaOpSbPlQGltDKt1riNIcRaZT3tIfgymo2OrN0a3NAXnVdxh4mI1y3sjRdZ93F2pDyooWvUg2DdaOH2OI8SNzoOmq+PPeXuFrKpk/YSZq/35yoOGCG5zTSMMs54taZDqzrQ/1ZSodri/+ZB24S4a3VOuz2UiRovLBde68x+GdfDcHHJTQn2Q5HDv0c7qcwYqP+CfOuST6uZg1atSCVan86M4Cz2aTOVGh3HV5kvUkSZETjqx9+VWdjmlcls6s5BSwwVKT3W2WM016H7RsSXndd0pRAhrVrj71uR4oWq0XKzkdEartgr3IqTECDlhmT4543HSCMn6tQ/6hpN0QoZobOS25Y76mACp++SPFrTcwNfE5WyzE0y9c0rauFrGzY5c0KmcTCQ4qe9zDAPOV8YEAf2HGqOolvtzD4wy0SBchLjQ3E7x3hoewAcooAoSvzRMaUVuoEVZtPuHp8iCwanJgHTgu3KN+wuuay8n1aNTFwlTkipYwbwmHrBMFfA6hvYLcqn5h4SubptoGEAJUDAWCC0+6Ee8dN25G/sqg1OYAS9Rb7lydYQsxsVwkehkadE2IgwvTNbh3oYVLMfQrJskMPwb3rHNF8BGuviImjXPAgIVG92/47wZiMhOTypWO+19hyy6+7rTkQ1Y0EjOsQYklShWkZWQ==";

  ApiClient() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers['Authorization'] = authorizationKey;
  }

  Future<ApiResponse?> getRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.get(endpoint, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        log("response -> ${response.toString()}");
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

  Future<ApiResponse?> postRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(endpoint, data: queryParameters);
      if (response.statusCode == 200) {
        log("response -> ${response.toString()}");
        ApiResponse apiResponse = ApiResponse<T>.fromJson(response.data);
        return apiResponse;
      } else {
        log("something went wrong");
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  void close() {
    dio.close();
  }
}
