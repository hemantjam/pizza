import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../order_delivery_controller.dart';
import 'delivery_now_controller.dart';

class DeliveryNowPage extends GetView<DeliveryNowController> {
  DeliveryNowPage({super.key});

  String selectedOption = 'Select an option';
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Store is close currently",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Enter Full Address",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              Card(
                child: TextFormField(
                  controller: controller.unitController,
                  focusNode: controller.unitFocus,
                  decoration: InputDecoration(hintText: "Enter Unit Number"),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: TextFormField(
                  controller: controller.streetNumberController,
                  focusNode: controller.streetNumberFocus,
                  decoration: InputDecoration(hintText: "Enter Street Number"),
                ),
              ),
              SizedBox(height: 10),
              PopupMenuButton<String>(
                onSelected: (String value) {
                  controller.streetNameController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return options.map((String option) {
                    return PopupMenuItem<String>(
                      value: option,
                      child: Row(
                        children: [
                          Expanded(child: Card(child: Text(option))),
                        ],
                      ),
                    );
                  }).toList();
                },
                child: IgnorePointer(
                  ignoring: true,
                  child: TextFormField(
                    controller: controller.streetNameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        hintText: "Street Name",
                        suffix: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: TextFormField(
                  controller: controller.postCodeController,
                  focusNode: controller.postCodeFocus,
                  decoration: InputDecoration(hintText: "Post Code"),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return Checkbox(
                        value: controller.rememberAddress.value,
                        onChanged: (value) {
                          controller.rememberAdd(value!);
                        });
                  }),
                  SizedBox(width: 5),
                  Text("Remember Delivery Details")
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                               backgroundColor:  MaterialStateProperty.all<Color>(Colors.black),
                            ),
                        onPressed: () {},
                        child: Text("Continue with the order",style:TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
