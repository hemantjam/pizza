import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../delivery_order_type/widgets/order_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/loader.dart';
import 'forgot_pass_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPassController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ForgotPassController>(
          init: Get.put(ForgotPassController()),
          builder: (logic) {
            return Scaffold(
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
                          customText(text: "Forget Password", fontSize: 24.sp),
                          SizedBox(
                            height: 1.h,
                          ),
                          customText(
                            text:
                                "Confirm your email and we will send the instructions",
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                          Obx(() {
                            return Visibility(
                              visible: controller.isOtpSent.value,
                              child: TextFormField(
                                controller: controller.otpController,
                                decoration: const InputDecoration(
                                    hintText: "Enter OTP"),
                                validator: (otp) {
                                  return otp!.isEmpty ? "* Required" : null;
                                },
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (otp) {
                                  controller.emailFocus.requestFocus();
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                              ),
                            );
                          }),
                          SizedBox(height: 1.h),
                          Obx(() {
                            return Visibility(
                              visible: controller.isOtpSent.value,
                              child: TextFormField(
                                controller: controller.newPassController,
                                decoration: const InputDecoration(
                                    hintText: "Enter New Password"),
                                validator: (pass) {
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
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (otp) {
                                  controller.emailFocus.requestFocus();
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            );
                          }),
                          SizedBox(height: 1.h),
                          Obx(() {
                            return TextFormField(
                              readOnly: controller.isOtpSent.value ,
                              controller: controller.emailController,
                              decoration: const InputDecoration(
                                  hintText: "Enter Email ID"),
                              validator: (email) {
                                return !GetUtils.isEmail(email!)
                                    ? "* Email is not valid"
                                    : null;
                              },
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (email) {
                                controller.emailFocus.unfocus();
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                            );
                          }),
                          SizedBox(height: 1.h),
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
                padding: const EdgeInsets.all(0.0),
                child: Obx(() {
                  return OrderButton(
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.isOtpSent.value
                            ? controller.submitOtp()
                            : controller.sendOtp();
                      }
                    },
                    enable: true,
                    text: controller.isOtpSent.value
                        ? "Submit new password"
                        : "Reset password / Send my password",
                  );
                }),
              ),
            );
          }),
    );
  }
}
