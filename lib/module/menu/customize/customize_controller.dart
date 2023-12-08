import 'package:get/get.dart';

import '../../../local_storage/app_database.dart';
import '../../../local_storage/entity/cart_items_entity.dart';
import '../by_group_code/menu_by_group_code_model.dart';

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
      .where((p0) => p0.isSelected)
      .map((element) =>
          element.values.fold(0, (sum, value) => sum + (value ? 1 : 0)))
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
      if (topping.isSelected) {
        int quantity = topping.values.where((value) => value).length;

        if (topping.isDefault && quantity > 1) {
          // If default topping and quantity > 1, calculate addon price for additional quantities
          int additionalQuantity = quantity - 1;
          toppingPrice += topping.addCost * additionalQuantity;
        } else if (!topping.isDefault) {
          // For non-default toppings, add cost for each quantity
          toppingPrice += topping.addCost * quantity;
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

  addToLocalDb({
  required String cartItemData,
  required String name,
  required int quantity,
  required int addon,
  required int total,
  required String selectedBase,
  required String selectedSize,}) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final cartItemsDoa = database.cartItemsDoa;
    CartItemsEntity entity = CartItemsEntity(
        itemModel: cartItemData,
        itemName: name,
        itemQuantity: quantity,
        selectedBase: selectedBase,
        selectedSize: selectedSize,
        addon: addon,
        total: total);

    await cartItemsDoa.insertCartItem(entity);
  }
}

class ToppingsSelection {
  int toppingId;
  String toppingName;
  bool isSelected;
  bool isDefault;
  int itemQuantity;
  List<bool> values;
  int defaultQuantity;
  int maximumQuantity;
  double addCost;
  bool canRemove;

  ToppingsSelection({
    required this.canRemove,
    required this.values,
    required this.defaultQuantity,
    required this.isDefault,
    required this.toppingName,
    required this.isSelected,
    required this.toppingId,
    required this.itemQuantity,
    required this.addCost,
    required this.maximumQuantity,
  });
  factory ToppingsSelection.fromJson(Map<String, dynamic> json) => ToppingsSelection(
    canRemove: json['canRemove'] as bool,
    values: (json['values'] as List<dynamic>?)!.map((e) => e as bool).toList(),
    defaultQuantity: json['defaultQuantity'] as int,
    isDefault: json['isDefault'] as bool,
    toppingName: json['toppingName'] as String,
    isSelected: json['isSelected'] as bool,
    toppingId: json['toppingId'] as int,
    itemQuantity: json['itemQuantity'] as int,
    addCost: json['addCost'] as double,
    maximumQuantity: json['maximumQuantity'] as int,
  );

  Map<String, dynamic> toJson() => {
    'canRemove': canRemove,
    'values': values,
    'defaultQuantity': defaultQuantity,
    'isDefault': isDefault,
    'toppingName': toppingName,
    'isSelected': isSelected,
    'toppingId': toppingId,
    'itemQuantity': itemQuantity,
    'addCost': addCost,
    'maximumQuantity': maximumQuantity,
  };
}

