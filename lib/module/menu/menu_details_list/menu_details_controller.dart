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
  RxMap<String, GroupModel> groupModelList = <String, GroupModel>{}.obs;

  final ApiServices _apiServices = ApiServices();
  RxList<MenuListModel> menuListModel = <MenuListModel>[].obs;

  MenuDetailsController(this.menuListModel);

  RxInt selectedItemIndex = 0.obs;

  @override
  void onInit() {
    menuListModel.where((p0) => p0.webDisplay!);
    super.onInit();
    checkForOfflineData();
  }

  checkForOfflineData() async {
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (!database.isBlank!) {
      final personDao = database.menuDetailsDoa;
      List<MenuDetailsTable> result = await personDao.findAllMenuDetails();
      log("----->result-->${result.length}");
      if (result.isEmpty) {
        await fetchAllMenu();
      } else {
        databaseToModel(result);
      }
    }
  }

  databaseToModel(List<MenuDetailsTable> result) {
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
    final menuDetails = MenuDetailsTable(
      DateTime.now().day +
          DateTime.now().year +
          DateTime.now().month +
          DateTime.now().millisecond,
      name,
      data,
    );
    await menuDetailsDao.insertGroupData(menuDetails);
  }

  Future<void> fetchAllMenu() async {
    if (menuListModel.isNotEmpty) {
      menuListModel.removeWhere((element) => !element.webDisplay!);
      await Future.wait(menuListModel.map((element) async {
        log("----->${element.name}");
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
