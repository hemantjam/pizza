import 'package:get/get.dart';
import 'package:pizza/module/menu/menu_controller.dart';

class MenuBiding extends Bindings {
  @override
  void dependencies() {
    Get.put(OutletMenuController());
  }
}
