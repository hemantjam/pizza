import 'package:get/get.dart';
import 'package:pizza/module/menu/menu_repository.dart';

import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_model.dart';

class OutletMenuController extends GetxController {
  final MenuRepository _repo = MenuRepository();
  RxList<MenuListModel> menuListModel = <MenuListModel>[].obs;
  MenuGroupCodeModel model = MenuGroupCodeModel();

  @override
  void onInit() {
    getMenu();
    super.onInit();
  }

  void getMenu() async {
    menuListModel.value = await _repo.getMenu();
    menuListModel.where((p0) => p0.webDisplay!);
    /* if (menuListModel.isNotEmpty) {
      Get.put(MenuDetailsController(menuListModel));
    }*/
  }
}
