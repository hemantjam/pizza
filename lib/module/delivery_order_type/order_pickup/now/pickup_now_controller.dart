import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:pizza/widgets/common_dialog.dart';

class PickUpNowController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController outletAddController = TextEditingController();

  Future<void> launchMapWithLocation() async {
    // final double sydneyLatitude = -33.8688;
    // final double sydneyLongitude = 151.2093;
    //  final String googleMapsUrl =
    //    'https://www.google.com/maps/search/?api=1&query=$sydneyLatitude,$sydneyLongitude';

    //  final String googleMapsUrl =
    //    'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    try {
      final availableMaps = await MapLauncher.installedMaps;
      if (availableMaps.isNotEmpty) {
        //final selectedMap = availableMaps.first;
        MapLauncher.showMarker(
            mapType: !Platform.isIOS ? MapType.google : MapType.apple,
            coords: Coords(-33.8688, 151.2093),
            title:  "Sydney, Australia",);
        /*  await selectedMap.showMarker(
          title: "Sydney, Australia",
          coords: Coords(-33.8688, 151.2093),
        );*/
      } else {
        showErrorDialog(
            title: "Map not found",
            message: "Map Application not found on this device");
      }
    } catch (e) {
      log("error:$e");
      showErrorDialog(
          title: "Something went wrong !",
          message: "can not open map.");
    }
  }

//final FocusNode unitFocus = FocusNode();
/* final TextEditingController unitController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  final FocusNode unitFocus = FocusNode();
  final FocusNode streetNumberFocus = FocusNode();
  final FocusNode streetNameFocus = FocusNode();
  final FocusNode postCodeFocus = FocusNode();*/

// final RxBool rememberAddress = false.obs;
// final RxBool isExpand = false.obs;
// RxString streetName = "Street Name".obs;
// RxString postCode = "Post Code".obs;

/*  void asignOutletAddress() {
    isExpand.value = !isExpand.value;
  }

  void rememberAdd(bool value) {
    rememberAddress.value = value;
  }*/
}
