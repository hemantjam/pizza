import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/local_storage/entity/menu_details_entity.dart';
import 'package:pizza/module/cart/model/order_create/add_to_cart_model.dart';
import 'package:pizza/module/cart/model/order_create/add_to_cart_payload.dart'as cartPayload;

import '../../../local_storage/app_database.dart';
import '../../../local_storage/entity/cart_items_entity.dart';
import '../../../widgets/common_dialog.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_model.dart';

class MenuDetailsController extends GetxController {
  MenuDetailsController(this.arguments);

  final Map<String, dynamic> arguments;

  RxMap<String, GroupModel> groupModelList = <String, GroupModel>{}.obs;
  Rx<MenuGroupCodeModel> buildYourPizzaModel = MenuGroupCodeModel().obs;
  final ApiServices _apiServices = ApiServices();
  RxList<MenuListModel> menuListModel = <MenuListModel>[].obs;
  Rx<RecipeModel?> recipeModel = RecipeModel().obs;

  ExpansionTileController tileController = ExpansionTileController();
  RxInt selectedItemIndex = 0.obs;
  RxString expandedCateName = "".obs;
  RxBool isExpanded = false.obs;
  ExpansionTileController? controller;

  toggleCateExpName(bool value, String newCate) {
    if (value) {
      expandedCateName.value = newCate;
    } else {
      expandedCateName.value = "";
    }
  }

  @override
  void onInit() {
    menuListModel = arguments["modelList"];
    selectedItemIndex.value = arguments["selectedIndex"];
    menuListModel.where((p0) => p0.webDisplay!);
    super.onInit();
    checkForOfflineData();
    buildYourPizza();
  }

  toggleRecipeModel(RecipeModel? recipeValue) {
    recipeModel.value = recipeValue;
    // recipeModel.value != null ? getAllToppingList(recipeValue!) : null;
    //update();
  }

  buildYourPizza() async {
    var data = {
      "groupCodes": ["G8"],
      "outletCode": "RJT01",
      "systemCode": "PIZZAPORTAL"
    };
    ApiResponse? res =
        await _apiServices.postRequest(ApiEndPoints.getMenuByCode, data: data);
    if (res != null && res.status) {
      buildYourPizzaModel.value = MenuGroupCodeModel.fromJson(res.toJson());
    } else {
      showCoomonErrorDialog(title: "Error", message: res?.message ?? "");
    }
    return null;
  }

  checkForOfflineData() async {
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (!database.isBlank!) {
      final menuDetailsDao = database.menuDetailsDoa;
      List<MenuDetailsEntity> result =
          await menuDetailsDao.findAllMenuDetails();
      if (result.isEmpty) {
        await fetchAllMenu();
      } else {
        databaseToModel(result);
      }
    }
  }

  databaseToModel(List<MenuDetailsEntity> result) {
    for (var element in result) {
      String res = element.groupData;
      Map<String, dynamic> resultMap = json.decode(res);
      groupModelList[element.groupName] = GroupModel.fromJson(resultMap);
    }
    update();
  }

  createDatabase(String name, String data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final menuDetailsDao = database.menuDetailsDoa;
    final menuDetails = MenuDetailsEntity(
      /*  DateTime.now().day +
          DateTime.now().year +
          DateTime.now().month +
          DateTime.now().millisecond,*/

      groupName: name,
      groupData: data,
    );
    await menuDetailsDao.insertGroupData(menuDetails);
  }

  Future<void> fetchAllMenu() async {
    if (menuListModel.isNotEmpty) {
      menuListModel.removeWhere((element) => !element.webDisplay!);
      await Future.wait(menuListModel.map((element) async {
        ApiResponse? res = await getMenu(element.code!);
        await createDatabase(
            element.code!, jsonEncode(res!.data[element.code!]).toString());
      }));
      checkForOfflineData();
      update();
    }
  }

  Future<ApiResponse?> getMenu(String code) async {
    var data = {
      "groupCodes": [code],
      "outletCode": "RJT01",
      "systemCode": "PIZZAPORTAL"
    };
    ApiResponse? res =
        await _apiServices.postRequest(ApiEndPoints.getMenuByCode, data: data);
    if (res != null && res.status) {
      return res;
    } else {
      showCoomonErrorDialog(title: "Error", message: res?.message ?? "");
    }
    return null;
  }

  Map<String, List<RecipeDetailsModel>> fetchCategories(GroupModel model) {
    List<String> categories = [];

    if (model.items != null) {
      model.items?.forEach((key, value) {
        if (value.availableCategories != null &&
            value.availableCategories!.isNotEmpty) {
          value.availableCategories?.forEach((element) {
            categories.add(element.name ?? "");
          });
        }
      });
    }

    return filterNewCategoryList(categories, model);
  }

  Map<String, List<RecipeDetailsModel>> filterNewCategoryList(
      List<String> categories, GroupModel model) {
    Map<String, List<RecipeDetailsModel>> categorizedRecipes = {};

    for (var categoryName in categories) {
      categorizedRecipes[categoryName] = (model.items?.entries
              .map((entry) => entry.value)
              .where((item) =>
                  item.availableCategories
                      ?.any((category) => category.name == categoryName) ==
                  true)
              .toList() ??
          <RecipeDetailsModel>[]);
    }
    return categorizedRecipes;
  }

  orderDetailsCreate(
    RecipeDetailsModel model,
    int quantity,
    String? selectedBase,
    String? selectedSize,
  ) async {
    RecipeModel? a = model.recipes
        ?.where((element) => element.size?.name == selectedSize)
        .first;
    BaseModel? baseModel = model.recipes
        ?.where((element) => element.size?.name == selectedSize)
        .first
        .base
        ?.where((element) => element.name == selectedBase)
        .first;
    cartPayload.AddToCartPayload payload = cartPayload.AddToCartPayload();
    List<ToppingsModel>? toppings = model.recipes
            ?.where((element) => element.size?.name == selectedSize)
            .first
            .toppings ??
        [];
    List<cartPayload.OrderRecipeItemWebRequestSet> itemSet =
        <cartPayload.OrderRecipeItemWebRequestSet>[];
    if (toppings.isNotEmpty) {
      for (var element in toppings) {
        cartPayload.OrderRecipeItemWebRequestSet orderRecipeItemWebRequestSet =
        cartPayload.OrderRecipeItemWebRequestSet(
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
    itemSet.add(cartPayload.OrderRecipeItemWebRequestSet(
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
    payload.orderMSTId =
        "58ad12a9-c8f7-4a00-9e76-9455386ce92c"; //TODO coming from ordermaster API
    payload.orderDTLRefId = "1";
    log("-->${jsonEncode(payload.toMap())}");
    ApiResponse? res = await _apiServices.postRequest(
        ApiEndPoints.orderDetailsCreate,
        data: jsonEncode(payload.toMap()));
    AddToCartResponseModel modelD=AddToCartResponseModel.fromMap(res!.toJson());
  }

  addToLocalDb({
    required String recipeDetailsModel,
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
    CartItemsEntity entity = CartItemsEntity(
      toppings: "[{}]",
      itemModel: recipeDetailsModel,
      itemName: name,
      itemQuantity: quantity,
      selectedBase: selectedBase,
      selectedSize: selectedSize,
      addon: addon,
      total: total,
    );

    await cartItemsDoa.insertCartItem(entity);
  }
}
