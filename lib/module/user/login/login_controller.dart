import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/user/logged_in_user/logged_in_user_model.dart';

import '../../../api/api_services.dart';
import '../../../local_storage/shared_pref.dart';
import 'login_model.dart';

class LoginController extends GetxController {
  LoggedInUserModel loggedInUserModel = Get.put(LoggedInUserModel());
  UserDataModel userDataModel = UserDataModel();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ApiServices apiServices = ApiServices();
  RxBool rememberMe = true.obs;
  RxBool showPass = false.obs;
  RxBool showLoading = false.obs;
  RxString userName = "".obs;

  @override
  void onInit() {
    super.onInit();
    getSavedCredential();
  }

  getSavedCredential() async {
    List<String>? creds = await SharedPref.fetchStringList("login_creds");
    if (creds != null) {
      emailController.text = creds[0];
      passController.text = creds[1];
    }
  }

  saveLoginCreds() {
    SharedPref.saveStringList("login_creds",
        [emailController.text.trim(), passController.text.trim()]);
  }

  deleteLoginCreds() {
    SharedPref.deleteData("login_creds");
  }

  void login(String email, String password) async {
    if (rememberMe.value) {
      saveLoginCreds();
    }
    if (!rememberMe.value) {
      deleteLoginCreds();
    }
    showLoading.value = true;
    ApiResponse? res = await apiServices.postRequest(
      ApiEndPoints.userLogin,
      data: {"userName": email, "password": password, "system": "PIZZAPORTAL"},
    );
    if (res != null && res.status) {
      userDataModel = UserDataModel.fromJson(res.toJson());
      if (userDataModel.data != null) {
             ApiEndPoints.authToken = userDataModel.data?.jwtToken ?? "";
          SharedPref.saveString("token", userDataModel.data?.jwtToken ?? "");
        showLoading.value = false;
        userName.value = userDataModel.data?.firstName ?? "";
        Get.put(userDataModel, permanent: true);
        handleNavigation();
      }
      showLoading.value = false;
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        showLoading.value = false;
      });
    }
    Future.delayed(const Duration(seconds: 3), () {
      showLoading.value = false;
    });
  }

  handleNavigation() {
    Get.toNamed(RouteNames.initial);
  }
}
