import 'package:get/get.dart';
import 'package:pizza/module/menu/customize/customize_controller.dart';

import '../by_group_code/menu_by_group_code_model.dart';

class CustomizePizzaBinding extends Bindings {
  @override
  void dependencies() {
    RecipeDetailsModel value = Get.arguments as RecipeDetailsModel;
    Get.put(CustomizePizzaController(value));
  }
}
