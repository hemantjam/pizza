import 'package:get/get.dart';
import 'package:pizza/module/menu/home_page_list/menu_controller.dart';

class MenuBiding extends Bindings {
  @override
  void dependencies() {
    Get.put(OutletMenuController());
  }
}
