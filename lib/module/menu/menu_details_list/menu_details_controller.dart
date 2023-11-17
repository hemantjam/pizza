import 'dart:developer';

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

  RxInt selectedItemIndex = 0.obs;
RxString totalPrice="".obs;
  @override
  void onInit() {
    getMenu();
    menuListModel.where((p0) => p0.webDisplay!);
    super.onInit();
  }

  filter() {
    //model.value.data.g1.items.the1PippoSSpecialPizza12.
  }

  getMenu() async {
    var data = {
      "groupCodes": ["G1"],
      "outletCode": "RJT01",
      "systemCode": "PIZZAPORTAL"
    };
    ApiResponse? res =
        await _apiServices.postRequest(ApiEndPoints.getMenuByCode, data: data);
    // log("-->response data--->${res?.data}");
    if (res != null && res.status) {
      model.value = MenuGroupCodeModel.fromJson(res.toJson());
      log("------>${model.value.data?.entries.first.value.items?.entries.first.toString()}");
      // GroupModel groupModel = GroupModel();
      //log("********${.toString()}");
      //  groupModel = GroupModel.fromJson(model.value.data?.values.first);
      // List<ItemModel> list = [];
      // log("===============${groupModel.items}");
      /* groupModel.items?.forEach((key, value) {
        list.add(ItemModel.fromJson(value));
      });*/
      // log("------------>${list.length}");
    } else {
      showCoomonErrorDialog(title: "Error", message: res?.message ?? "");
    }
  }
}
