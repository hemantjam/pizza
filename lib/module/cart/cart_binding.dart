import 'package:get/get.dart';
import 'package:pizza/module/cart/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CartController>(CartController(),permanent: true,tag: "cartController");
  }
}
