import 'package:get/get.dart';

import 'delivery_now_controller.dart';

class OrderDeliveryNowBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DeliveryNowController());
  }
}
