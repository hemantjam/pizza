import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/user/register/register_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';
import '../../delivery_order_type/widgets/order_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/loader.dart';

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
          child: Stack(
            children: [
              Form(
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

                      /// first name
                      TextFormField(
                        controller: controller.firstNameController,
                        focusNode: controller.firstNameFocus,
                        decoration:
                            const InputDecoration(hintText: "Enter First Name"),
                        validator: (fName) {
                          RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');

                          return nameRegex.hasMatch(fName!)
                              ? null
                              : "* Only alphabets are allowed";
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (fName) {
                          controller.lastNameFocus.requestFocus();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                      ),

                      /// last name
                      TextFormField(
                        controller: controller.lastNameController,
                        focusNode: controller.lastNameFocus,
                        decoration:
                            const InputDecoration(hintText: "Enter Last Name"),
                        validator: (lName) {
                          RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');

                          return nameRegex.hasMatch(lName!)
                              ? null
                              : "* Only alphabets are allowed";
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (lName) {
                          controller.emailFocus.requestFocus();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                      ),

                      /// email
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
                          controller.numberFocus.requestFocus();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      /// mobile number
                      TextFormField(
                        controller: controller.numberController,
                        focusNode: controller.numberFocus,
                        decoration: const InputDecoration(
                            hintText: "Enter Mobile Number"),
                        validator: (number) {
                          RegExp nameRegex = RegExp(r'^[0-9]+$');
                          return nameRegex.hasMatch(number!)
                              ? null
                              : "* Only numbers are allowed";
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (number) {
                          controller.passFocus.requestFocus();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),

                      /// password
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
                          onFieldSubmitted: (pass) {
                            controller.cPassFocus.requestFocus();
                          },
                          obscureText: !controller.showPass.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        );
                      }),

                      /// confirm password
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
                            return controller.cPassController.text.trim() !=
                                    controller.passController.text.trim()
                                ? "* Confirm password not match"
                                : null;
                          },
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (cpass) {
                            controller.numberFocus.requestFocus();
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
                          customText(
                              text: "Email Subscription", fontSize: 12.sp),
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
                    ],
                  ),
                ),
              ),
              Obx(() {
                return loader(controller.showLoading.value);
              })
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OrderButton(
              onTap: () {
                if(controller.formKey.currentState!.validate()){
                  controller.register();
                }
              },
              enable: true,
              text: "Sign Up",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(text: "Don't have an account ?", fontSize: 12.sp),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Get.back();
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
    );
  }
}
