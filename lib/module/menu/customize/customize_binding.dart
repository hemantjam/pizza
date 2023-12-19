import 'package:get/get.dart';
import 'package:pizza/module/menu/customize/customize_controller.dart';


class CustomizePizzaBinding extends Bindings {
  @override
  void dependencies() {
    Map<String,dynamic>arguments=Get.arguments;
   // RecipeDetailsModel value = Get.arguments as RecipeDetailsModel;
    Get.put(CustomizePizzaController(arguments));
  }
}
