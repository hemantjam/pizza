import 'package:get/get.dart';

import '../by_group_code/menu_by_group_code_model.dart';

class CustomizePizzaController extends GetxController {
  final Map<String, dynamic> arguments;
  RecipeDetailsModel? recipeDetailsModel;

  CustomizePizzaController(this.arguments);

  RxList<ToppingsSelection> allToppings = <ToppingsSelection>[].obs;
  Rx<RecipeModel?> recipeModel = RecipeModel().obs;
  late RxBool isBuildYourOwnPizza;

  @override
  void onInit() {
    isBuildYourOwnPizza = RxBool(false);
    recipeDetailsModel = arguments["model"];
    isBuildYourOwnPizza.value = arguments["isBuildYourOwn"] ?? false;
    super.onInit();
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
          addCost: element.addCost ?? 0,
          toppingName: element.name,
          isSelected:
              element.defaultQuantity != null && element.defaultQuantity != 0,
          toppingId: element.id,
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
