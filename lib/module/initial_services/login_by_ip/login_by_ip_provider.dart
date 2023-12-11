/*
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/module/initial_services/login_by_ip/login_by_ip_model.dart';

import '../../../api/api_services.dart';

class LoginByIpProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  bool loading = true;

  loginByIp() async {
    loading = true;
    ApiResponse res = await apiServices.getRequest(ApiEndPoints.loginByIp);
    if (res.status) {
      LoginByIpModel loginByIpModel = LoginByIpModel.fromJson(res.toJson());

      //ApiEndPoints.authToken = res.data["jwtToken"];
     ApiEndPoints.authToken = loginByIpModel.data?.jwtToken ?? "";
      getPizzaPortalToken(ApiEndPoints.authToken);
    }
  }

  getPizzaPortalToken(String token) async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
        ApiEndPoints.addIntoSystem,
        token: token,
        queryParameters: {},
        data: '"pizzaportal"');
    if (res.status) {
      ApiEndPoints.authToken = res.data.toString();
      getSystemToken(ApiEndPoints.authToken);
    }
  }

  getSystemToken(String token) async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
        ApiEndPoints.addIntoOutlet,
        token: token,
        queryParameters: {},
        data: '"rjt01"');
    String systemToken = "systemToken";
    if (res.status) {
      systemToken = res.data.toString();
      ApiEndPoints.authToken = res.data.toString();
    }
    if (ApiEndPoints.authToken == systemToken) {
      loading = false;
    }

  }
}
*/
