import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/module/menu/by_group_code/menu_by_group_code_model.dart';

import '../../local_storage/app_database.dart';
import '../../local_storage/entity/cart_items_entity.dart';

class CartController extends GetxController {
  RxList<CartItemsEntity> cartItems = <CartItemsEntity>[].obs;
  RxMap<String,RecipeModel?>cartItemsList= <String,RecipeModel?>{}.obs;
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
    }  }
  checkForOfflineData() async {
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (!database.isBlank!) {
      final cartItemsDao = database.cartItemsDoa;
      List<CartItemsEntity> result = await cartItemsDao.findAllCartItems();

      if (result.isNotEmpty) {
        cartItemsList.clear();
       // cartItems.value = result;
        result.forEach((element) {
         // log("----->data---->${element.itemData}");
          cartItemsList[element.itemName] =
            RecipeModel.fromJson(jsonDecode(element.itemModel));
        });
      } /*else {
        //databaseToModel(result);
      }*/
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
