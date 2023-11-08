import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api/api_services.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ApiServices apiClient = ApiServices();
  RxBool rememberMe = false.obs;
  RxBool showPass = false.obs;

  void login() async {}

  void forgotPassword() {}
}
