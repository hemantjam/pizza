import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/delivery_order_type/widgets/order_button.dart';
import 'package:pizza/module/user/login/login_controller.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_text.dart';

class LogInPage extends GetView<LoginController> {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText(text: "Sign In", fontSize: 24.sp),
                SizedBox(
                  height: 1.h,
                ),
                customText(
                  text: "To retain fantastic deals",
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextFormField(
                  controller: controller.emailController,
                  focusNode: controller.emailFocus,
                  decoration: const InputDecoration(hintText: "Enter Email ID"),
                  validator: (email) {
                    return !GetUtils.isEmail(email!)
                        ? "* Email is not valid"
                        : null;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (email) {
                    controller.passFocus.requestFocus();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                ),
                Obx(() {
                  return TextFormField(
                    controller: controller.passController,
                    focusNode: controller.passFocus,
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.showPass.value =
                            !controller.showPass.value;
                          },
                          icon: Icon(!controller.showPass.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    validator: (pass) {
                      return pass!.isEmpty || pass.length < 8
                          ? "* Password are not valid"
                          : null;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (email) {
                      controller.passFocus.unfocus();
                    },
                    obscureText: !controller.showPass.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  );
                }),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Obx(() {
                      return Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (bool? value) {
                            controller.rememberMe.value = value!;
                          });
                    }),
                    customText(text: "Remember Me", fontSize: 12.sp),
                    const Spacer(),
                    customText(
                      text: "Forgot Password ?",
                      fontSize: 12.sp,
                      color: AppColors.lightOrange,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OrderButton(
                onTap: () {
                  showLoadingDialog();
                  /*  if (controller.formKey.currentState!.validate()) {
                    showErrorDialog(
                        title: "Login", message: "Login Successful");
                  }*/
                },
                enable: true,
                text: "Sign In",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(text: "Don't have an account ?", fontSize: 12.sp),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteNames.register);
                    },
                    child: customText(
                      text: "Sign Up",
                      fontSize: 12.sp,
                      color: AppColors.lightOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showLoadingDialog() {
  return Get.dialog(
    Center(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: const Padding(
          padding: EdgeInsets.all(40.0),
          child: CupertinoActivityIndicator(
            color: Colors.orange,
            radius: 30,
          ),
        ),
      ),
    ),
  );
}
