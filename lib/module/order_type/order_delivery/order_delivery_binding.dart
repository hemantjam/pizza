import 'package:get/get.dart';

import 'order_delivery_controller.dart';

class DeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DeliveryController());
  }
}
