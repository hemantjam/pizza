import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryLaterController extends GetxController {
   GlobalKey<FormState> formKey = GlobalKey<FormState>();

   TextEditingController dateController = TextEditingController();
   TextEditingController timeController = TextEditingController();

   TextEditingController unitController = TextEditingController();
   TextEditingController streetNumberController = TextEditingController();
   TextEditingController streetNameController = TextEditingController();
   TextEditingController postCodeController = TextEditingController();


  final FocusNode unitFocus = FocusNode();
  final FocusNode streetNumberFocus = FocusNode();
  final FocusNode streetNameFocus = FocusNode();
  final FocusNode postCodeFocus = FocusNode();

  final RxBool rememberAddress = false.obs;
  RxString date = "".obs;
  RxString time = "".obs;

  rememberAdd(bool value) {
    rememberAddress.value = value;
  }
}
