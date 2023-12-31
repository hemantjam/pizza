import 'package:get/get.dart';

import '../by_group_code/menu_by_group_code_model.dart';
import 'local_toppings_module.dart';

class CustomizePizzaController extends GetxController {
  final Map<String, dynamic> arguments;
  RecipeDetailsModel? recipeDetailsModel;

  CustomizePizzaController(this.arguments);

  RxList<ToppingsSelection> allToppings = <ToppingsSelection>[].obs;
  Rx<RecipeModel?> recipeModel = RecipeModel().obs;
  late RxBool isBuildYourOwnPizza;
  RxInt addOnToppings = 0.obs;

  int get maxSlots =>
      recipeModel.value?.toppingsInfo?.toppings?.maximumQuantity?.ceil() ?? 0;

  int get filledSlots => allToppings
      .where((p0) => p0.isSelected!)
      .map((element) =>
          element.values!.fold(0, (sum, value) => sum + (value! ? 1 : 0)))
      .toList()
      .fold(0, (sum, count) => sum + count);

  @override
  void onInit() {
    isBuildYourOwnPizza = RxBool(false);
    recipeDetailsModel = arguments["model"];
    isBuildYourOwnPizza.value = arguments["isBuildYourOwn"] ?? false;
    super.onInit();
  }

  double calculateToppingsPrice() {
    double toppingPrice = 0.0;

    for (var topping in allToppings) {
      if (topping.isSelected!) {
        int quantity = topping.values!.where((value) => value!).length;

        if (topping.isDefault! && quantity > 1) {
          // If default topping and quantity > 1, calculate addon price for additional quantities
          int additionalQuantity = quantity - 1;
          toppingPrice += topping.addCost! * additionalQuantity;
        } else if (!topping.isDefault!) {
          // For non-default toppings, add cost for each quantity
          toppingPrice += topping.addCost! * quantity;
        }
      }
    }
    return toppingPrice;
  }

  void addTopping(ToppingsSelection toppingsSelection) {
    int index = allToppings
        .indexWhere((p0) => p0.toppingId == toppingsSelection.toppingId);
    allToppings.removeAt(index);
    allToppings.insert(index, toppingsSelection);
  }

  getAllToppingList(RecipeModel recipeValue) {
    allToppings.clear();
    recipeValue.toppings?.forEach((element) {
      ToppingsSelection toppingsSelection = ToppingsSelection(
          canRemove: element.defaultQuantity?.ceil() == 1.0,
          values: List.generate(
            element.maximumQuantity?.ceil() ?? 0,
            (index) => index < (element.defaultQuantity?.ceil() ?? 0).toInt(),
          ),
          defaultQuantity: element.defaultQuantity?.ceil() ?? 0,
          isDefault:
              element.defaultQuantity != null && element.defaultQuantity != 0.0,
          addCost: element.addCost ?? 0,
          toppingName: element.name ?? "",
          isSelected:
              element.defaultQuantity != null && element.defaultQuantity != 0,
          toppingId: element.id ?? 0,
          itemQuantity: element.itemQuantity?.ceil() ?? 0,
          maximumQuantity: element.maximumQuantity?.ceil() ?? 0);
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
