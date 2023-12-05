import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/delivery_order_type/widgets/order_button.dart';
import 'package:pizza/module/user/login/login_controller.dart';
import 'package:pizza/module/user/widgets/loader.dart';
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
          child: Stack(
            children: [
              Form(
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
                      decoration:
                          const InputDecoration(hintText: "Enter Email ID"),
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
                          // RegExp passwordRegex = RegExp(
                          //     r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])(.{8,16})$');

                          if (pass!.length < 8) {
                            return "Password must be at least 8 characters long";
                          }

                          if (!RegExp(r'[A-Z]').hasMatch(pass)) {
                            return "Password must contain at least one uppercase letter";
                          }

                          if (!RegExp(r'\d').hasMatch(pass)) {
                            return "Password must contain at least one number";
                          }

                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                              .hasMatch(pass)) {
                            return "Password must contain at least one special character";
                          }
                          return null;
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
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteNames.forgotPass);
                          },
                          child: customText(
                            text: "Forgot Password ?",
                            fontSize: 12.sp,
                            color: AppColors.lightOrange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
              Obx(() {
                return loader(controller.showLoading.value);
              })
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OrderButton(
                onTap: () {
                  //  controller.showLoading.value = !controller.showLoading.value;
                  //controller.login();
                  if (controller.formKey.currentState!.validate()) {
                    controller.login(controller.emailController.text.trim(),
                        controller.passController.text.trim());
                  }
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
