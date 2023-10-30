import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/constants/route_names.dart';

import '../../api/api_response.dart';
import '../../api/api_services.dart';

class SplashController extends GetxController {
  RxBool loading = false.obs;
  ApiServices apiServices = ApiServices();

  @override
  void onReady() {
    super.onReady();
    getToken();
    loading.value ? handleNavigation() : null;
  }

  void handleNavigation() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed(RouteNames.homePage);
    });
  }

  getToken() async {
    loading.value = true;
    var res = await apiServices.getRequest(ApiEndPoints.loginByIp);
    if (res != null && res.status) {
      ApiEndPoints.authToken = res.data["jwtToken"];
      getPizzaPortalToken(ApiEndPoints.authToken);
    }
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
    // notifyListeners();
  }

  getSystemToken(String token) async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
        ApiEndPoints.rjt01,
        token: token,
        queryParameters: {},
        data: {});
    String systemToken = "systemToken";
    if (res != null && res.status) {
      systemToken = res.data.toString();
      ApiEndPoints.authToken = res.data.toString();
    }
    if (ApiEndPoints.authToken == systemToken) {
      loading.value = false;
    }
    // notifyListeners();
  }
}
