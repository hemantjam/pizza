import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';

import '../../../widgets/common_dialog.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_model.dart';

class MenuDetailsController extends GetxController {
  Rx<MenuGroupCodeModel> model = MenuGroupCodeModel().obs;

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
    getMenu();
    menuListModel.where((p0) => p0.webDisplay!);
    super.onInit();
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
      getCategories();
    }
  }

  getCategories() {
    if (model.value.data != null) {
      for (var element in model.value.data!.entries) {
        if (element.value.items != null) {
          element.value.items?.forEach((key, value) {
            if (value.availableCategories != null ||
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
