import 'dart:convert';

import 'package:get/get.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/module/cart/model/order_create/add_to_cart_payload.dart'
    as cart_payload;

import '../../../api/api_response.dart';
import '../../../api/end_point.dart';
import '../../../local_storage/app_database.dart';
import '../../../local_storage/entity/cart_items_entity.dart';
import '../../cart/model/order_create/add_to_cart_model.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import 'local_toppings_module.dart';

class CustomizePizzaController extends GetxController {
  final Map<String, dynamic> arguments;
  RecipeDetailsModel? recipeDetailsModel;

  CustomizePizzaController(this.arguments);

  final ApiServices _apiServices = ApiServices();

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

        if (topping!.isDefault! && quantity > 1) {
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

  Future<bool> orderDetailsCreate(RecipeDetailsModel model, int quantity,
      String? selectedBase, String? selectedSize, String? orderMSTId) async {
    RecipeModel? a = model.recipes
        ?.where((element) => element.size?.name == selectedSize)
        .first;
    BaseModel? baseModel = model.recipes
        ?.where((element) => element.size?.name == selectedSize)
        .first
        .base
        ?.where((element) => element.name == selectedBase)
        .first;
    cart_payload.AddToCartPayload payload = cart_payload.AddToCartPayload();
    List<ToppingsModel>? toppings = model.recipes
            ?.where((element) => element.size?.name == selectedSize)
            .first
            .toppings ??
        [];
    List<cart_payload.OrderRecipeItemWebRequestSet> itemSet =
        <cart_payload.OrderRecipeItemWebRequestSet>[];
    if (toppings.isNotEmpty) {
      for (var element in toppings) {
        cart_payload.OrderRecipeItemWebRequestSet orderRecipeItemWebRequestSet =
            cart_payload.OrderRecipeItemWebRequestSet(
          recipeItemDTLId: element.id,
          qty: element.itemQuantity?.ceil(),
          defaultQty: element.defaultQuantity?.ceil(),
          sortOrder: 1,
          base: false,
          active: model.isActive,
        );
        itemSet.add(orderRecipeItemWebRequestSet);
      }
    }
    itemSet.add(cart_payload.OrderRecipeItemWebRequestSet(
      qty: 1,
      recipeItemDTLId: baseModel?.id,
      defaultQty: baseModel?.defaultQuantity?.ceil(),
      sortOrder: baseModel?.sortOrder,
      base: true,
      active: true,
    ));
    payload.active = model.isActive;
    payload.displayName = model.name;
    payload.itemMSTId = model.id;
    payload.recipeMSTId = a?.id;
    payload.qty = quantity;
    payload.orderRecipeItemWebRequestSet = itemSet;
    payload.orderStage = "DS01";
    payload.hnhSurcharge = 0;
    payload.additionalValue = 0;
    payload.sortOrder = 1;
    payload.orderMSTId = orderMSTId;
    payload.orderDTLRefId = "1";
    ApiResponse? res = await _apiServices.postRequest(
        ApiEndPoints.orderDetailsCreate,
        data: jsonEncode(payload.toMap()));
    if (res != null && res.status) {
      AddToCartResponseModel addToCartResponseModel =
          AddToCartResponseModel.fromMap(res.toJson());
      Get.put(addToCartResponseModel);
    }
    return res?.status ?? false;
  }

  addToLocalDb({
    required String cartItemData,
    required String name,
    required int quantity,
    required int addon,
    required int total,
    required String selectedBase,
    required String selectedSize,
  }) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final cartItemsDoa = database.cartItemsDoa;
    List<ToppingsSelection> selectedToppings =
        allToppings.where((p0) => p0.isSelected!).toList();
    List<Map<String, dynamic>> toppingsJsonList =
        selectedToppings.map((topping) => topping.toJson()).toList();
    String toppingsJsonString = jsonEncode(toppingsJsonList);
    CartItemsEntity entity = CartItemsEntity(
        toppings: toppingsJsonString,
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
