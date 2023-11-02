import 'package:get/get.dart';

import 'delivery_now_controller.dart';

class DeliveryNowBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DeliveryNowController());
  }
}
