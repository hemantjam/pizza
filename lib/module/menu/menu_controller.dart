import 'package:get/get.dart';
import 'package:pizza/module/menu/menu_repository.dart';

import 'menu_model.dart';

class OutletMenuController extends GetxController {
  final MenuRepository _repo = MenuRepository();
  RxList<MenuListModel> menuListModel = <MenuListModel>[].obs;

  @override
  void onInit() {
    getMenu();
    super.onInit();
  }

  void getMenu() async {
    menuListModel.value = await _repo.getMenu();
  }
}
