import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/module/menu/menu_details_list/local_storage/menu_details.dart';

import '../../../widgets/common_dialog.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_model.dart';
import 'local_storage/menu_details_database.dart';

class MenuDetailsController extends GetxController {
  Rx<MenuGroupCodeModel> model = MenuGroupCodeModel().obs;
  Rx<GroupModel> groupModel = GroupModel().obs;

  final ApiServices _apiServices = ApiServices();
  RxList<MenuListModel> menuListModel = <MenuListModel>[].obs;

  MenuDetailsController(this.menuListModel);

  RxList<BaseModel?> sizes = <BaseModel?>[].obs;
  RxSet<String> categories = <String>{}.obs;
  RxMap<String, List<RecipeDetailsModel>> categorizedRecipes =
      <String, List<RecipeDetailsModel>>{}.obs;
  RxInt selectedItemIndex = 0.obs;
  RxString totalPrice = "".obs;

  @override
  void onInit() {
    // getMenu();
    menuListModel.where((p0) => p0.webDisplay!);
    super.onInit();
    checkForOfflineData();
  }

  checkForOfflineData() async {
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    log("---->database status-->${database.isBlank!}");
    if (!database.isBlank!) {
      final personDao = database.menuDetailsDoa;
      var result = await personDao.findAllMenuDetails();
      log("----->result-->${result.length}");
      if (result.isEmpty) {
        getMenu();
      }
      else {
        log("----->${result.first.groupData.runtimeType}");
        String res = result.first.groupData;
        Map<String, dynamic> resultMap = json.decode(res);
        groupModel.value = GroupModel.fromJson(resultMap);
        log("===after model parce====>");
        log("===${groupModel.value.items?.length}====>");
        update();
      }
      result.forEach((element) {
        log("-id->${element.id}");
         log("-name->${element.groupName}");
       log("-data->${element.groupData}");
      });
    }
  }

  initDatabase(String name, String data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final personDao = database.menuDetailsDoa;
    final person = MenuDetailsTable(
      DateTime.now().day +
          DateTime.now().year +
          DateTime.now().month +
          DateTime.now().millisecond,
      name,
      data,
    );
    await personDao.insertGroupData(person);
    var result = await personDao.findAllMenuDetails();
    result.forEach((element) {
      // log("-id->${element.id}");
      //log("-name->${element.groupName}");
      //  log("-data->${element.groupData}");
    });
  }

  getMenu() async {
    var data = {
      "groupCodes": ["G1"],
      "outletCode": "RJT01",
      "systemCode": "PIZZAPORTAL"
    };
    ApiResponse? res =
        await _apiServices.postRequest(ApiEndPoints.getMenuByCode, data: data);

    if (res != null && res.status) {
      model.value = MenuGroupCodeModel.fromJson(res.toJson());
    } else {
      showCoomonErrorDialog(title: "Error", message: res?.message ?? "");
    }
    if (model.value.data != null) {
      initDatabase(
          model.value.data!.entries.first.key,jsonEncode(res!.data["G1"]) .toString());
      getCategories();
    }
  }

  getCategories() {
    categories.clear();
    if (model.value.data != null) {
      for (var element in model.value.data!.entries) {
        if (element.value.items != null) {
          element.value.items?.forEach((key, value) {
            if (value.availableCategories != null &&
                value.availableCategories!.isNotEmpty) {
              value.availableCategories?.forEach((element) {
                categories.add(element.name ?? "");
              });
            }
          });
        }
      }
    }
    filterCategoryList();
  }

  filterCategoryList() {
    for (var categoryName in categories) {
      categorizedRecipes[categoryName] = (model.value.data?.entries
              .map((entry) => entry.value.items?.values)
              .expand<RecipeDetailsModel>((items) => items ?? [])
              .where((item) =>
                  item.availableCategories
                      ?.any((category) => category.name == categoryName) ==
                  true)
              .toList() ??
          <RecipeDetailsModel>[]);
    }
  }
}
