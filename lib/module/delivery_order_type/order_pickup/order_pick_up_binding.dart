import 'package:get/get.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/order_pick_up_controller.dart';

class OrderPickUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderPickUpController());
  }
}
