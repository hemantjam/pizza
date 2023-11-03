import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';

import 'all_active_model.dart';
import 'byType/street_name_model.dart';

class AllActiveController extends GetxController {
  ApiServices apiServices = ApiServices();
  Rx<AllActiveOutletGeographyModel> allActiveOutletGeographyModel =
      AllActiveOutletGeographyModel().obs;
  Rx<GeographyByTypeModel> streetNameList = GeographyByTypeModel().obs;
  Rx<GeographyByTypeModel> postCodeList = GeographyByTypeModel().obs;

  @override
  void onReady() {
    super.onReady();
    getAllActiveOutlet();
    getStreetName();
    getPostCode();
  }

  void getAllActiveOutlet() async {
    ApiResponse res =
        await apiServices.getRequest(ApiEndPoints.allActiveOutlet);
    if (res.status) {
      allActiveOutletGeographyModel.value =
          AllActiveOutletGeographyModel.fromJson(res.toJson());
    }
    update();
  }

  void getStreetName() async {
    ApiResponse res = await apiServices
        .getRequest(ApiEndPoints.geoghraphyByTypeCode, data: "/GT6");
    if (res.status) {
      streetNameList.value = GeographyByTypeModel.fromJson(res.toJson());
    }
    update();
  }

  void getPostCode() async {
    ApiResponse res = await apiServices
        .getRequest(ApiEndPoints.geoghraphyByTypeCode, data: "/GT4");
    if (res.status) {
      postCodeList.value = GeographyByTypeModel.fromJson(res.toJson());
    }
    update();
  }
}
