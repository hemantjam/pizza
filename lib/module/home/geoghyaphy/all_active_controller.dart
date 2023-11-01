import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/module/home/geoghyaphy/all_active_model.dart';

import 'byType/by_type_model.dart';

class AllActiveController extends GetxController {
  ApiServices apiServices = ApiServices();
  Rx<AllActiveOutletModel> model = AllActiveOutletModel().obs;
  Rx<GeoghyaphyByTypeModel> typeModel = GeoghyaphyByTypeModel().obs;

  @override
  void onReady() {
    super.onReady();
    getAllActiveOutlet();
    geoghraphyByCode();
  }

  void getAllActiveOutlet() async {
    ApiResponse res =
        await apiServices.getRequest(ApiEndPoints.allActiveOutlet);
    if (res.status) {
      model.value = AllActiveOutletModel.fromJson(res.toJson());
      log("+++++${model.value.data?.length.toString()}");
    }
    update();
  }

  void geoghraphyByCode() async {
    ApiResponse res = await apiServices
        .getRequest(ApiEndPoints.geoghraphyByTypeCode, data: "/GT6");
    if (res.status) {
      typeModel.value = GeoghyaphyByTypeModel.fromJson(res.toJson());
      log("======>${typeModel.value.data?.length.toString()}");
    }
    update();
  }
}
