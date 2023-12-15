import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/module/menu/by_group_code/menu_by_group_code_model.dart';

import '../../local_storage/app_database.dart';
import '../../local_storage/entity/cart_items_entity.dart';

class CartController extends GetxController {
  RxList<CartItemsEntity> cartItems = <CartItemsEntity>[].obs;
  RxList<RecipeDetailsModel?> cartItemsList = <RecipeDetailsModel?>[].obs;

  @override
  onInit() {
    super.onInit();
    checkForOfflineData();
  }

  @override
  onReady() {
    checkForOfflineData();
    super.onReady();
  }

  deleteData(CartItemsEntity cartItemsEntity) async {
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    if (!database.isBlank!) {
      final cartItemsDao = database.cartItemsDoa;
      await cartItemsDao.deleteSingleCartItem(cartItemsEntity.id!);
      checkForOfflineData();
    }
    update();
  }

  checkForOfflineData() async {
    cartItemsList.clear();
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (!database.isBlank!) {
      final cartItemsDao = database.cartItemsDoa;
      List<CartItemsEntity> result = await cartItemsDao.findAllCartItems();
      if (result.isNotEmpty) {
        cartItems.value = result;
        for (var element in cartItems) {
          log("${element.id}");
          log(element.itemName);
          try {
            cartItemsList.add(
                RecipeDetailsModel.fromJson(jsonDecode(element.itemModel)));
          } catch (e) {}
        }
      }
    }
    update();
  }

/*databaseToModel(List<CartItemsEntity> result) {
    */ /*for (var element in result) {
      String res = element.groupData;
      Map<String, dynamic> resultMap = json.decode(res);
      groupModelList[element.groupName] = GroupModel.fromJson(resultMap);
    }*/ /*
    update();
  }*/
}
