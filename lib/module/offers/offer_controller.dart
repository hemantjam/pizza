import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/module/offers/offer_info_model.dart';

import '../../api/api_response.dart';
import '../../api/api_services.dart';
import '../../api/end_point.dart';

class OfferController extends GetxController {
  ApiServices apiClient = ApiServices();
  Rx<OfferInfoModel> offerInfoModel = OfferInfoModel().obs;

  @override
  void onInit() {
    getOffers();
    super.onInit();
  }
  getOffers() async {
   var res = await apiClient.getRequest(ApiEndPoints.offerInfo);
   log("====>${res.toString()}");
   // offerInfoModel.value= OfferInfoModel.fromJson(res as Map<String ,dynamic>);
    log("---------->${offerInfoModel.value.toString()}");
    update();
  }
}
