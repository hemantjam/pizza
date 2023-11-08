import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_services.dart';

class RegisterController extends GetxController{
  ApiServices apiClient = ApiServices();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController cPassController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode cPassFocus = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool rememberMe = false.obs;
  RxBool emailSub = false.obs;
  RxBool smsSub = false.obs;
  RxBool showPass = false.obs;
  RxBool showConfirmPass = false.obs;

  void register() async {}

}