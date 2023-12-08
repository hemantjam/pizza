import 'dart:convert';

import 'package:get/get.dart';
import 'package:pizza/module/menu/by_group_code/menu_by_group_code_model.dart';

import '../../local_storage/app_database.dart';
import '../../local_storage/entity/cart_items_entity.dart';

class CartController extends GetxController {
  RxList<CartItemsEntity> cartItems = <CartItemsEntity>[].obs;
  RxList< RecipeDetailsModel?> cartItemsList =
      <RecipeDetailsModel?>[].obs;

  @override
  onInit() {
    super.onInit();
    checkForOfflineData();
  }

  deleteData() async {
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (!database.isBlank!) {
      final cartItemsDao = database.cartItemsDoa;
      // cartItemsDao.deleteAllCart(cartItemsEntity);
    }
  }

  checkForOfflineData() async {
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (!database.isBlank!) {
      final cartItemsDao = database.cartItemsDoa;
      List<CartItemsEntity> result = await cartItemsDao.findAllCartItems();

      if (result.isNotEmpty) {
      //  cartItemsList.clear();
      //  cartItems.clear();
        cartItems.value = result;
        for (var element in cartItems) {
          cartItemsList.add(
              RecipeDetailsModel.fromJson(jsonDecode(element.itemModel)));
        }
      }
    }
  }

  databaseToModel(List<CartItemsEntity> result) {
    /*for (var element in result) {
      String res = element.groupData;
      Map<String, dynamic> resultMap = json.decode(res);
      groupModelList[element.groupName] = GroupModel.fromJson(resultMap);
    }*/
    update();
  }
}
