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
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                      controller: controller.forgotPassController,
                      // focusNode: controller.emailFocus,
                      decoration:
                          const InputDecoration(hintText: "Enter Email ID"),
                      validator: (email) {
                        return !GetUtils.isEmail(email!)
                            ? "* Email is not valid"
                            : null;
                      },
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (email) {
                        controller.forgotPassFocus.unfocus();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                    ),
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
                  controller.showLoading.value = !controller.showLoading.value;
                },
                enable: true,
                text: "Reset password / Send my password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
