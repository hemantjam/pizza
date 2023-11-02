import 'package:get/get.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/later/pickup_later_controller.dart';

class PickUpLaterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PickUpLaterController());
  }
}
