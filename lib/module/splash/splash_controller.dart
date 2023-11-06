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
    ever(loading, (callback) => !loading.value ? handleNavigation() : null);
  }

  void handleNavigation() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed(RouteNames.homePage);
    });
  }

  getToken() async {
    loading.value = true;
    var res = await apiServices.getRequest(ApiEndPoints.loginByIp);
    if (res.status) {
      ApiEndPoints.authToken = res.data["jwtToken"];
      getSystemToken(ApiEndPoints.authToken);
    }
  }

  getSystemToken(String token) async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
        ApiEndPoints.addIntoSystem,
        token: token,
        queryParameters: {},
        data: "pizzaportal");
    if (res.status) {
      ApiEndPoints.authToken = res.data.toString();
      getOutletToken(ApiEndPoints.authToken);
    }
  }

  getOutletToken(String token) async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
        ApiEndPoints.addIntoOutlet,
        token: token,
        queryParameters: {},
        data: "rjt01");
    String systemToken = "systemToken";
    if (res.status) {
      systemToken = res.data.toString();
      ApiEndPoints.authToken = res.data.toString();
    }
   // log("\ntokensss-------->${systemToken}\n\n\n${ApiEndPoints.authToken}\n\n");
    if (ApiEndPoints.authToken == systemToken) {
      loading.value = false;
    }else {
      //loading.value = true;
    }
  }
}
