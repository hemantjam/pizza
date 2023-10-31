import 'package:get/get.dart';

import 'delivery_later_controller.dart';

class OrderDeliveryLaterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DeliveryLaterController());
  }
}
