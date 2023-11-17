import 'package:get/get.dart';

import '../menu_model.dart';
import 'menu_details_controller.dart';

class MenuDetailsBinding extends Bindings {
  MenuDetailsBinding();
  // menuListModel = <MenuListModel>[].obs;

  @override
  void dependencies() {
    final RxList<MenuListModel> model = Get.arguments as RxList<MenuListModel>;
    Get.lazyPut(() => MenuDetailsController(model));
  }
}
