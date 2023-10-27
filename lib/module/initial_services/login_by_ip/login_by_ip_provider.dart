import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/end_point.dart';

import '../../../api/api_services.dart';

class LoginByIpProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  bool loading = true;

  loginByIp() async {
    loading = true;
    var res = await apiServices.getRequest(ApiEndPoints.loginByIp);
    if (res != null && res.status) {
      ApiEndPoints.authToken = res.data["jwtToken"];
      getPizzaPortalToken(ApiEndPoints.authToken);
    }
    notifyListeners();
  }

  getPizzaPortalToken(String token) async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
        ApiEndPoints.addIntoPizza,
        token: token,
        queryParameters: {},
        data: {});
    if (res != null && res.status) {
      ApiEndPoints.authToken = res.data.toString();
      getSystemToken(ApiEndPoints.authToken);
    }
    notifyListeners();
  }

  getSystemToken(String token) async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
        ApiEndPoints.rjt01,
        token: token,
        queryParameters: {},

        data: {});
    String systemToken="systemToken";
    if (res != null && res.status) {
      systemToken= res.data.toString();
      ApiEndPoints.authToken = res.data.toString();
    }
    if(ApiEndPoints.authToken ==systemToken){
      loading=false;
    }
    notifyListeners();
  }
}
