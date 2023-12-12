import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/local_storage/shared_pref.dart';
import 'package:pizza/module/user/login/login_controller.dart';

import '../../api/api_response.dart';
import '../../api/api_services.dart';
import '../user/logged_in_user/logged_in_user_model.dart';

class SplashController extends GetxController {
  RxBool loading = false.obs;
  ApiServices apiServices = ApiServices();
  LoginController loginController = Get.put(LoginController());
  LoggedInUserModel loggedInUserModel = LoggedInUserModel();
  RxBool serverIssue = false.obs;
  RxString userName = "".obs;

  @override
  void onReady() {
    super.onReady();
    checkLoggedInUser();
    ever(loading, (callback) => !loading.value ? handleNavigation() : null);
  }

  void handleNavigation() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(RouteNames.homePage);
    });
  }

  Future<String?> getOfflineToken() async {
    return await SharedPref.fetchString("token");
  }

  saveOfflineToken(String data) {
    SharedPref.saveString("token", data);
  }

  checkLoggedInUser() async {
    String? token = await getOfflineToken();
    ApiEndPoints.authToken = token ?? "";
    ApiResponse? res = await apiServices.getRequest(ApiEndPoints.userLoggedIn);
    //log("==>${res?.toJson()}");
    if (res != null && res.status) {
      loggedInUserModel = LoggedInUserModel.fromJson(res.toJson());

      Get.put<LoggedInUserModel>(loggedInUserModel, permanent: true,tag: "login");
      if (!loggedInUserModel.data!.userMST!.ipUser!) {
        userName.value =
            "${loggedInUserModel.data?.customerMST?.customerFirstName ?? ""} ${loggedInUserModel.data?.customerMST?.customerLastName ?? ""}";
      }
      getSystemToken();
      loading.value = false;
    } else {
      loginByIp();
    }
    update();
  }

  loginByIp() async {
    loading.value = true;
    ApiResponse? res = await apiServices.getRequest(ApiEndPoints.loginByIp);
    if (res != null && res.status) {
      ApiEndPoints.authToken = res.data["jwtToken"];
      saveOfflineToken(ApiEndPoints.authToken);
      getSystemToken();
    } else {
      serverIssue.value = true;
    }
  }

  getSystemToken() async {
    ApiResponse? res = await apiServices.postRequest(ApiEndPoints.addIntoSystem,
        data: '"' + 'PIZZAPORTAL' + '"');
    if (res != null && res.status) {
      ApiEndPoints.authToken = res.data.toString();
      saveOfflineToken(ApiEndPoints.authToken);
      getOutletToken();
    } else {
      serverIssue.value = true;
    }
  }

  getOutletToken() async {
    ApiResponse? res = await apiServices.postRequest(
      ApiEndPoints.addIntoOutlet,
      data: '"' + 'rjt01' + '"',
    );
    if (res != null && res.status) {
      ApiEndPoints.authToken = res.data.toString();
      saveOfflineToken(ApiEndPoints.authToken);
      loading.value = false;
    } else {
      serverIssue.value = true;
    }
  }
}
