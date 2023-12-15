import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/local_storage/entity/menu_details_entity.dart';
import 'package:pizza/module/cart/cart_controller.dart';
import 'package:pizza/module/cart/model/order_create/add_to_cart_model.dart';
import 'package:pizza/module/cart/model/order_create/add_to_cart_payload.dart'
    as cart_payload;
import 'package:pizza/module/user/widgets/loader.dart';

import '../../../local_storage/app_database.dart';
import '../../../local_storage/entity/cart_items_entity.dart';
import '../../../widgets/common_dialog.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import '../customize/local_toppings_module.dart';
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





}
