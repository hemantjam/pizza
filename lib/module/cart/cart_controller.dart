import 'dart:convert';

import 'package:get/get.dart';
import 'package:pizza/module/menu/by_group_code/menu_by_group_code_model.dart';

import '../../local_storage/app_database.dart';
import '../../local_storage/entity/cart_items_entity.dart';

class CartController extends GetxController {
  RxList<CartItemsEntity> cartItems = <CartItemsEntity>[].obs;

  int get cartItemsLength => cartItems.length;

  int get cartTotal => cartItems.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.total * element.itemQuantity));
  RecipeDetailsModel? recipeDetailsModel;

  updateTotal(int id, int quantity) {
    cartItems.where((p0) => p0.id == id).first.itemQuantity = quantity;
    cartTotal;
    update();
  }

  updateLocalCartItem(CartItemsEntity cartItemsEntity) async {
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    if (!database.isBlank!) {
      final cartItemsDao = database.cartItemsDoa;
      cartItemsDao.updateCartItem(cartItemsEntity);
    }
  }

  @override
  onInit() {
    recipeDetailsModel = GetInstance()
            .isRegistered<RecipeDetailsModel>(tag: "recipeDetailsModel")
        ? Get.find<RecipeDetailsModel>(tag: "recipeDetailsModel")
        : null;

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
    AppDatabase? database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (!database.isBlank!) {
      cartItems.clear();
      final cartItemsDao = database.cartItemsDoa;
      List<CartItemsEntity> result = await cartItemsDao.findAllCartItems();
      if (result.isNotEmpty) {
        cartItems.value = result;
      }
    }
    update();
  }

  Future<List<CartItemsEntity>> getModelsList() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (!database.isBlank!) {
      final cartItemsDao = database.cartItemsDoa;
      final result = await cartItemsDao.findAllCartItems();

      if (result.isNotEmpty) {
       return result;
      }
    }
    return [];
  }
}
