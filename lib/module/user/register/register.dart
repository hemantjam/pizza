import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/user/register/register_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/route_names.dart';
import '../../delivery_order_type/widgets/order_button.dart';
import '../widgets/custom_text.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Container(
          //alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customText(text: "Sign Up", fontSize: 24.sp),
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
                        return pass!.isEmpty || pass.length < 8
                            ? "* Password are not valid"
                            : null;
                      },
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (pass) {
                        controller.cPassFocus.requestFocus();
                      },
                      obscureText: !controller.showPass.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    );
                  }),
                  Obx(() {
                    return TextFormField(
                      controller: controller.cPassController,
                      focusNode: controller.cPassFocus,
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showConfirmPass.value =
                                  !controller.showConfirmPass.value;
                            },
                            icon: Icon(!controller.showConfirmPass.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      validator: (cpass) {
                        return cpass != controller.passController.text
                            ? "* Password are not match"
                            : null;
                      },
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (cpass) {
                        controller.cPassFocus.unfocus();
                      },
                      obscureText: !controller.showConfirmPass.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    );
                  }),
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
                    ],
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Checkbox(
                            value: controller.emailSub.value,
                            onChanged: (bool? value) {
                              controller.emailSub.value = value!;
                            });
                      }),
                      customText(text: "Email Subscription", fontSize: 12.sp),
                    ],
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Checkbox(
                            value: controller.smsSub.value,
                            onChanged: (bool? value) {
                              controller.smsSub.value = value!;
                            });
                      }),
                      customText(text: "SMS Subscription", fontSize: 12.sp),
                    ],
                  ),
                  OrderButton(
                    onTap: () {},
                    enable: true,
                    text: "Sign Up",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                          text: "Don't have an account ?", fontSize: 12.sp),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteNames.login);
                        },
                        child: customText(
                          text: "Sign In",
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
        ),
      ),
    );
  }
}
