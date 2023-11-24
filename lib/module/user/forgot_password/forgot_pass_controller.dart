import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/widgets/common_dialog.dart';

import '../../../constants/route_names.dart';

class ForgotPassController extends GetxController {
  ApiServices apiServices = ApiServices();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode otpFocus = FocusNode();
  FocusNode newPassFocus = FocusNode();

  RxBool showLoading = false.obs;
  RxBool isOtpSent = false.obs;


  sendOtp() async {
    showLoading.value = true;
    ApiResponse? response = await apiServices
        .postRequest(ApiEndPoints.forgotPassword, data: {
      "username": emailController.text.trim(),
      "remarks": "Pineapple"
    });
    if (response != null && response.status) {
      showCoomonErrorDialog(
          title: "Success", message: "OTP sent to your email-ID");
      isOtpSent.value = true;
      // showNewPassword.value = true;
    } else if (response != null && !response.status) {
      showCoomonErrorDialog(title: "Error", message: response.message);
    }
    showLoading.value = false;
  }

  submitOtp() async {
    showLoading.value = true;
    ApiResponse? response =
        await apiServices.postRequest(ApiEndPoints.resetPassword, data: {
      "newPassword": newPassController.text.trim(),
      "otp": otpController.text.trim(),
      "remarks": "Pineapple",
      "username": emailController.text.trim()
    });
    if (response != null && response.status) {
      showCoomonErrorDialog(title: "Success", message: "Please login again");
      Get.back();
      handleNavigate();
    } else if (response != null && !response.status) {
      showCoomonErrorDialog(title: "Error", message: response.message);
    }
    showLoading.value = false;
  }
  handleNavigate() {
    Get.toNamed(RouteNames.initial);
  }
}
