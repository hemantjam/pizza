import 'package:get/get.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/now/pickup_now_controller.dart';

class PickUpNowBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PickUpNowController());
  }
}
