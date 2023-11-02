import 'package:get/get.dart';

import 'order_delivery_controller.dart';

class OrderDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderDeliveryController());
  }
}
