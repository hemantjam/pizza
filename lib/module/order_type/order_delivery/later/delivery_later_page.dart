import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'delivery_later_controller.dart';

class OderDeliveryLaterPage extends GetView<DeliveryLaterController> {
  OderDeliveryLaterPage({super.key});

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
                "Date",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),

              PopupMenuButton<String>(
                onSelected: (String value) {
                  controller.dateController.text=value;
                },
                itemBuilder: (BuildContext context) {
                  return options.map((String option) {
                    return PopupMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList();
                },
                child: IgnorePointer(
                  ignoring: true,
                  child: TextFormField(
                    controller: controller.dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        hintText: "Select Date",
                        suffix: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Time",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),

              PopupMenuButton<String>(
                onSelected: (String value) {
                  controller.timeController.text=value;
                },
                itemBuilder: (BuildContext context) {
                  return options.map((String option) {
                    return PopupMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList();
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: controller.timeController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        hintText: "Select Time",
                        suffix: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              const SizedBox(
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
                  decoration: const InputDecoration(hintText: "Enter Unit Number"),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: TextFormField(
                  controller: controller.streetNumberController,
                  focusNode: controller.streetNumberFocus,
                  decoration: const InputDecoration(hintText: "Enter Street Number"),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: TextFormField(
                  controller: controller.streetNameController,
                  focusNode: controller.streetNameFocus,
                  decoration: const InputDecoration(hintText: "Street Name"),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: TextFormField(
                  controller: controller.postCodeController,
                  focusNode: controller.postCodeFocus,
                  decoration: const InputDecoration(hintText: "Post Code"),
                ),
              ),
              const SizedBox(height: 10),
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
                  const SizedBox(width: 5),
                  const Text("Remember Delivery Details")
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
