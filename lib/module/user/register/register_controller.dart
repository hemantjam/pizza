import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/local_storage/shared_pref.dart';
import 'package:pizza/module/user/register/register_model.dart';

import '../../../api/api_response.dart';
import '../../../api/api_services.dart';
import '../../../api/end_point.dart';

class RegisterController extends GetxController {
  ApiServices apiServices = ApiServices();
  Rx<RegisterModel> registerModel = Get.put(RegisterModel()).obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController cPassController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode cPassFocus = FocusNode();
  final FocusNode numberFocus = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool rememberMe = false.obs;
  RxBool emailSub = false.obs;
  RxBool smsSub = false.obs;
  RxBool showPass = false.obs;
  RxBool showConfirmPass = false.obs;
  RxBool showLoading = false.obs;

  void register() async {
    showLoading.value = true;
    ApiResponse res = await apiServices.postRequest(
      ApiEndPoints.register,
      data: {
        "confirmPassword": cPassController.text.trim(),
        "customerFirstName": firstNameController.text.trim(),
        "customerLastName": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "emailSubscription": emailSub.value,
        "mobile": numberController.text.trim(),
        "password": passController.text.trim(),
        "remarks": "Pineapple",
        "signUp": true,
        "smsSubscription": smsSub.value,
        "system": "PIZZAPORTAL"
      },
    );
    //log("register response-->${res.toJson()}");
    if (res.status) {
      showLoading.value = false;
      if (registerModel.value.data != null) {
        registerModel.value = RegisterModel.fromJson(res.toJson());
        ApiEndPoints.authToken =
            registerModel.value.data?.login?.jwtToken ?? "";
        SharedPref.saveString(
            "token", registerModel.value.data?.login?.jwtToken ?? "");
      }
      handleNavigate();
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        showLoading.value = false;
      });
    }
    Future.delayed(const Duration(seconds: 3), () {
      showLoading.value = false;
    });
  }
}

handleNavigate() {
  Get.toNamed(RouteNames.initial);
}
/*
confirmPasswor:"Pizza@2023"
customerFirstName:"hemant"
customerLastName:"fsaf"
email:"hj@gmail.com"
emailSubscription:true
mobile:"9876432100"
password:"Pizza@2023"
remarks    :"Pineapple"
signUp    :true
smsSubscription    :true
system    :"PIZZAPORTAL"*/
