import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../../../home/geoghyaphy/byType/by_type_model.dart';
import '../order_delivery_controller.dart';
import 'delivery_now_controller.dart';

class DeliveryNowPage extends GetView<DeliveryNowController> {
  const DeliveryNowPage({super.key});


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
            children: [
              Text(
                "Store is closed currently",
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
                  fontWeight: FontWeight.bold,
                ),
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
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        controller.toggleExpand();
                      },
                      contentPadding: EdgeInsets.only(bottom: 4.0),
                      title: Text(
                        controller.streetName.value,
                        style: TextStyle(
                            color: controller.streetName == "Street Name"
                                ? Colors.grey.shade600
                                : Colors.black),
                      ),
                      trailing: Icon(controller.isExpand.value
                          ? Icons.arrow_drop_up
                          : Icons.keyboard_arrow_down),
                      shape: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isExpand.value,
                      child: Card(
                        child: SizedBox(
                          height: 200,
                          child: controller.streetList == null ||
                                  controller.streetList!.isEmpty
                              ? Center(child: Text("No Data Found !"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.streetList?.length,
                                  itemBuilder: (context, int index) {
                                    SingleGeoghraphyModel item =
                                        controller.streetList![index];
                                    return ListTile(
                                      onTap: () {
                                        controller.streetName.value =
                                            item.geographyName ?? "";
                                        controller.toggleExpand();
                                        //controller.postCode.value=item.
                                      },
                                      title: Text(
                                        item.geographyName ?? "",
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 10),
              Card(
                child: TextFormField(
                  readOnly: true,
                  controller: controller.postCodeController,
                  focusNode: controller.postCodeFocus,
                  decoration:
                      InputDecoration(hintText: controller.postCode.value),
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
                      },
                    );
                  }),
                  SizedBox(width: 5),
                  Text("Remember Delivery Details"),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Continue with the order",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
