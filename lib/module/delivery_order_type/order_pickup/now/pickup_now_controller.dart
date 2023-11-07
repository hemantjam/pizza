
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../outlet_details/outlet/outlet_controller.dart';
import '../../../outlet_details/outlet/outlet_model.dart';

class PickUpNowController extends GetxController {
  Rx<OutletController> outletController = OutletController().obs;
  Rx<OutletModel> outletModel = OutletModel().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController outletAddController =
      TextEditingController(text: "77, Hoffmans Rd, NIDDRIE, 3042");
  final RxString outletAddress = "77, Hoffmans Rd, NIDDRIE, 3042".obs;
  RxBool storeOff = false.obs;

  @override
  onInit() {
    super.onInit();
    getOutletDetails();
    ever(
        outletController.value.outletAddress, (callback) => getOutletDetails());
  }

  getOutletDetails() {
    outletAddController.text = outletController.value.outletAddress.value;

  }

  Future<void> launchMapWithAddress(String address) async {
    try {
      final query = Uri.encodeComponent(address);
      final url = 'https://www.google.com/maps/search/?api=1&query=$query';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      log("Error: $e");
    }
  }
}
