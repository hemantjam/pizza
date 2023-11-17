import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';

class OutletController extends GetxController {
  Rx<String> outletAddress = "".obs;
  ApiServices apiServices = ApiServices();

  @override
  onInit() {
    super.onInit();
    getOutletDetails();
  }

  getOutletDetails() async {

    ApiResponse? res = await apiServices
        .getRequest(ApiEndPoints.outletDetailsByCode, data: "RJT01");
    if (res!=null&&res.status) {
      outletAddress.value = res.data["address1"];
    }
   
    update();
  }
}
