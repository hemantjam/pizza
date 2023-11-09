import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController forgotPassController =TextEditingController();
FocusNode forgotPassFocus=FocusNode();
RxBool showLoading=false.obs;
sendPassToEmail(){
  showLoading.value = true;
  Future.delayed(Duration(seconds: 3), () {
    showLoading.value = false;
  });
}
}