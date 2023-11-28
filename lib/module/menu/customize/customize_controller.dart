import 'dart:developer';

import 'package:get/get.dart';

import '../by_group_code/menu_by_group_code_model.dart';

class CustomizePizzaController extends GetxController {
  final RecipeDetailsModel recipeDetailsModel;

  CustomizePizzaController(this.recipeDetailsModel);

  RxList<ToppingsSelection> allToppings = <ToppingsSelection>[].obs;
  Rx<RecipeModel?> recipeModel = RecipeModel().obs;

  // RxList<ToppingsModel>? selectedToppings = <ToppingsModel>[].obs;

  void addTopping(ToppingsSelection toppingsSelection) {
    //allToppings.removeLast();
    int index = allToppings
        .indexWhere((p0) => p0.toppingId == toppingsSelection.toppingId);
    allToppings.removeAt(index);
    allToppings.insert(index, toppingsSelection);
    /*  allToppings.removeWhere(
        (element) => element.toppingId == toppingsSelection.toppingId);
    allToppings.add(toppingsSelection);*/
    //allToppings.sort();

    /* int? existingIndex = allToppings.indexWhere(
        (element) => element.toppingId == toppingsSelection.toppingId);

    if (existingIndex != -1) {
      allToppings[existingIndex].isSelected =
          !allToppings[existingIndex].isSelected;
      allToppings[existingIndex].selectedQuantity =
          toppingsSelection.selectedQuantity;
    }
    update();*/
  }

  getAllToppingList(RecipeModel recipeValue) {
    allToppings.clear();
    recipeValue.toppings?.forEach((element) {
      ToppingsSelection toppingsSelection = ToppingsSelection(
        addCost: element.addCost??0,
          toppingName: element.name,
          isSelected: false,
          toppingId: element.id,
          selectedQuantity: 0,
          maximumQuantity: element.maximumQuantity?.toInt() ?? 0);
      allToppings.add(toppingsSelection);
    });
    update();
  }

  toggleRecipeModel(RecipeModel? recipeValue) {
    recipeModel.value = recipeValue;
    log("-------->method${recipeModel.value?.toppings?.length}");
    recipeModel.value != null ? getAllToppingList(recipeValue!) : null;
    update();
  }
}

class ToppingsSelection {
  int? toppingId;
  String? toppingName;
  bool isSelected;
  int selectedQuantity;
  int maximumQuantity;
  double addCost;

  ToppingsSelection(
      {required this.toppingName,
      required this.isSelected,
      required this.toppingId,
      required this.selectedQuantity,
      required this.addCost,
      required this.maximumQuantity});
}
