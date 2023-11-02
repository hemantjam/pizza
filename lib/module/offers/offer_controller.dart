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
    ApiResponse<dynamic>? res =
        await apiClient.getRequest(ApiEndPoints.offerInfo);
    offerInfoModel.value =
        OfferInfoModel.fromJson(res.data as Map<String, dynamic>);

    update();
  }
}
