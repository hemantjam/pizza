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
  Rx<LoggedInUserModel> loggedInUserModel = LoggedInUserModel().obs;

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
    ApiResponse res = await apiServices.getRequest(ApiEndPoints.userLoggedIn);
    if (res.status) {
      loginController.userName.value ="assigned";
      loggedInUserModel.value = LoggedInUserModel.fromJson(res.toJson());
      loginController.userName.value ="assigned";
          //loggedInUserModel.value.data?.customerMST?.customerFirstName ?? "";
      loading.value = false;
    } else if (!res.status) {
      loginByIp();
    }
  }

  loginByIp() async {
    loading.value = true;
    var res = await apiServices.getRequest(ApiEndPoints.loginByIp);
    if (res.status) {
      ApiEndPoints.authToken = res.data["jwtToken"];
      saveOfflineToken(ApiEndPoints.authToken);
      getSystemToken();
    }
  }

  getSystemToken() async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
        ApiEndPoints.addIntoSystem,
        data: '"' + 'PIZZAPORTAL' + '"');
    if (res.status) {
      ApiEndPoints.authToken = res.data.toString();
      saveOfflineToken(ApiEndPoints.authToken);
      getOutletToken();
    }
  }

  getOutletToken() async {
    ApiResponse<dynamic>? res = await apiServices.postRequest(
      ApiEndPoints.addIntoOutlet,
      data: '"' + 'rjt01' + '"',
    );
    if (res.status) {
      ApiEndPoints.authToken = res.data.toString();
      saveOfflineToken(ApiEndPoints.authToken);
      loading.value = false;
    }
  }
}
