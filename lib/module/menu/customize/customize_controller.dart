import 'dart:developer';

import 'package:get/get.dart';

import '../by_group_code/menu_by_group_code_model.dart';

class CustomizePizzaController extends GetxController {
  final Map<String, dynamic> arguments;
  RecipeDetailsModel? recipeDetailsModel;

  CustomizePizzaController(this.arguments);

  RxList<ToppingsSelection> allToppings = <ToppingsSelection>[].obs;
  Rx<RecipeModel?> recipeModel = RecipeModel().obs;
  late RxBool isBuildYourOwnPizza;
  RxInt addOnToppings = 0.obs;

  @override
  void onInit() {
    isBuildYourOwnPizza = RxBool(false);
    recipeDetailsModel = arguments["model"];
    isBuildYourOwnPizza.value = arguments["isBuildYourOwn"] ?? false;
    super.onInit();
  }

  void addTopping(ToppingsSelection toppingsSelection) {
    log("--->${toppingsSelection.isDefault}");
    int index = allToppings
        .indexWhere((p0) => p0.toppingId == toppingsSelection.toppingId);
    allToppings.removeAt(index);
    allToppings.insert(index, toppingsSelection);
  }

  getAllToppingList(RecipeModel recipeValue) {
    allToppings.clear();
    recipeValue.toppings?.forEach((element) {
      ToppingsSelection toppingsSelection = ToppingsSelection(
        defaultQuantity: element.defaultQuantity??0,
          totalSelected: element.defaultQuantity ?? 0,
          isDefault:
              element.defaultQuantity != null && element.defaultQuantity != 0.0,
          addCost:
              element.defaultQuantity != null && element.defaultQuantity != 0
                  ? element.addCost!
                  : 0,
          toppingName: element.name ?? "",
          isSelected:
              element.defaultQuantity != null && element.defaultQuantity != 0,
          toppingId: element.id ?? 0,
          selectedQuantity: 0,
          maximumQuantity: element.maximumQuantity?.toInt() ?? 0);
      allToppings.add(toppingsSelection);
    });
    update();
  }

  toggleRecipeModel(RecipeModel? recipeValue) {
    recipeModel.value = recipeValue;
    recipeModel.value != null ? getAllToppingList(recipeValue!) : null;
    update();
  }



}

class ToppingsSelection {
  int toppingId;
  String toppingName;
  bool isSelected;
  bool isDefault;
  int selectedQuantity;
  int maximumQuantity;
  double addCost;
  double totalSelected;
  double defaultQuantity;

  ToppingsSelection({
    required this.defaultQuantity,
    required this.isDefault,
    required this.totalSelected,
    required this.toppingName,
    required this.isSelected,
    required this.toppingId,
    required this.selectedQuantity,
    required this.addCost,
    required this.maximumQuantity,
  });


}
