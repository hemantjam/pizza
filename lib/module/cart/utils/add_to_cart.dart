import 'dart:convert';
import 'package:get/get.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/module/cart/cart_controller.dart';

import '../../../api/api_response.dart';
import '../../../api/end_point.dart';
import '../../../local_storage/app_database.dart';
import '../../../local_storage/entity/cart_items_entity.dart';
import '../../../widgets/common_dialog.dart';
import '../../menu/by_group_code/menu_by_group_code_model.dart';
import '../../user/widgets/loader.dart';
import '../model/order_create/add_to_cart_model.dart';
import '../model/order_create/add_to_cart_payload.dart' as cart_payload;

ApiServices _apiServices = ApiServices();

orderDetailsCreate(
  RecipeDetailsModel model,
  int quantity,
  String? selectedBase,
  String? selectedSize,
  String? orderMSTId,
  int basePrice,
) async {
  showCommonLoading(true);
 /* final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();*/
  RecipeModel? recipeModel = model.recipes
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
  List<cart_payload.OrderRecipeItemWebRequestSet>? itemSet =
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
  if (baseModel != null) {
    itemSet.add(cart_payload.OrderRecipeItemWebRequestSet(
      qty: 1,
      recipeItemDTLId: baseModel.id,
      defaultQty: baseModel.defaultQuantity?.ceil(),
      sortOrder: baseModel.sortOrder,
      base: true,
      active: true,
    ));
  }

  payload.active = model.isActive;
  payload.displayName = model.name;
  payload.itemMSTId = model.id;
  payload.recipeMSTId = recipeModel?.id;
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
    Get.put<AddToCartResponseModel>(addToCartResponseModel, permanent: true);
   /* OrderCreateResponseDoa orderCreateResponseDoa =
        database.orderCreateResponseDoa;*/
    if (addToCartResponseModel.data != null) {
      /*orderCreateResponseDoa.insertResData(OrderCreateResponseEntity(
          resData: jsonEncode(addToCartResponseModel.data?.toMap()),
          resId: addToCartResponseModel.data?.id ?? ""));*/
      bool? notified = await notifySSE();
      if (notified != null && notified) {
        addToLocalDb(
          addToCartResponseModel:
              addToCartResponseModel.data ?? AddToCartResponseData(),
          recipeDetailsModel: jsonEncode(model.toJson()),
          name: model.name ?? "",
          quantity: quantity,
          addon: 0,
          basePrice: basePrice,
          selectedBase: selectedBase ?? "",
          selectedSize: selectedSize ?? "",
        );
      }
    }
  }
  Get.isDialogOpen??false?Get.back():null;
  /*Get.put<RecipeDetailsModel>(model,
      tag: "recipeDetailsModel", permanent: true);
  Get.back();
  return res?.status ?? false;*/
}

Future<bool?> notifySSE() async {
  ApiResponse? res = await _apiServices.getRequest(ApiEndPoints.notifySSE);
  return res?.status;
}

addToLocalDb(
    {required String recipeDetailsModel,
    required String name,
    required int quantity,
    required int addon,
    required int basePrice,
    required String selectedBase,
    required String selectedSize,
    required AddToCartResponseData addToCartResponseModel}) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  final cartItemsDoa = database.cartItemsDoa;

  CartItemsEntity entity = CartItemsEntity(
    orderCreateResponse: jsonEncode(addToCartResponseModel.toMap()),
    itemModel: recipeDetailsModel,
    itemName: name,
    itemQuantity: quantity,
    selectedBase: selectedBase,
    selectedSize: selectedSize,
    addon: addon,
    basePrice: basePrice,
    isOffer: false,
  );
  await cartItemsDoa.insertCartItem(entity);
  CartController controller = Get.find();
  controller.checkForOfflineData();
  showCoomonErrorDialog(
      title: "Success", message: "Successfully added to cart");
  return;
}

/*List<ToppingsSelection> getAllToppingList(RecipeModel recipeValue) {
  List<ToppingsSelection> allToppings = [];
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
  return allToppings;
}*/
