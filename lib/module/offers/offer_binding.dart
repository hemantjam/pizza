import 'package:get/get.dart';
import 'package:pizza/module/offers/offer_controller.dart';

class OfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OfferController());
  }
}
