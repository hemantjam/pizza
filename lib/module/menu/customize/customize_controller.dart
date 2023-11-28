import 'package:get/get.dart';

import '../by_group_code/menu_by_group_code_model.dart';

class CustomizePizzaController extends GetxController {
  final RecipeDetailsModel recipeDetailsModel;

  CustomizePizzaController(this.recipeDetailsModel);

  Rx<RecipeModel?> recipeModel=RecipeModel().obs;
  final selectedToppings = <Topping>[].obs;
  final availableToppings = [
    Topping(name: "Mushrooms", minQuantity: 1, maxQuantity: 3),
    Topping(name: "Pepperoni", minQuantity: 1, maxQuantity: 3),
    Topping(name: "Onions", minQuantity: 1, maxQuantity: 3),
    Topping(name: "Olives", minQuantity: 1, maxQuantity: 3),
    Topping(name: "Bell Peppers", minQuantity: 1, maxQuantity: 3),
  ].obs;

  void addTopping(Topping topping) {
    selectedToppings.add(topping);
    availableToppings.remove(topping);
  }

  toggleRecipeModel(RecipeModel? recipeValue) {
    recipeModel.value = recipeValue;
    update();
  }

  void removeTopping(Topping topping) {
    selectedToppings.remove(topping);
    availableToppings.add(topping);
  }
}

class Topping {
  String name;
  int minQuantity;
  int maxQuantity;

  Topping({
    required this.name,
    required this.minQuantity,
    required this.maxQuantity,
  });

// toJson and fromJson methods go here...
}
