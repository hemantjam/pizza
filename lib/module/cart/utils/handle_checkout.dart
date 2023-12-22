import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/widgets/common_dialog.dart';

import '../../../local_storage/entity/cart_items_entity.dart';
import '../../menu/by_group_code/menu_by_group_code_model.dart';
import '../model/order_create/add_to_cart_model.dart' as add_to_cart;
import '../model/order_master/order_master_create_model.dart';
import '../model/order_master/order_mst_update_payload.dart';

class CheckOut {
  static final ApiServices _apiServices = ApiServices();

  static cartUpdate(List<CartItemsEntity?>? cartItems) async {
    OrderMstUpdatePayload payload = OrderMstUpdatePayload();

    final orderMstCreateModel =
        Get.find<OrderMasterCreateModel>(tag: "orderMasterCreateModel");

    payload.orderMstWebRequest?.expressOrder = false;
    payload.orderMstWebRequest?.orderType = orderMstCreateModel.data?.orderType;
    payload.orderMstWebRequest?.active = orderMstCreateModel.data?.active;
    payload.orderMstWebRequest?.id = orderMstCreateModel.data?.id;
    payload.orderMstWebRequest?.customerAddressDtl =
        orderMstCreateModel.data?.customerAddressDtl;
    payload.orderMstWebRequest?.orderDate = "2023-12-21";
    payload.orderMstWebRequest?.orderStageCode = "DS01";
    payload.orderMstWebRequest?.otherInstrucation = "";
    payload.orderMstWebRequest?.deliveyInstrucation = "";
    payload.orderMstWebRequest?.userId = orderMstCreateModel.data?.userId;
    payload.orderMstWebRequest?.appliedAmount = 0;
    payload.orderMstWebRequest?.customerName =
        orderMstCreateModel.data?.customerName;
    List<OrderDtlWebRequestSet>? orderDtlWebRequestList = [];
    if (cartItems != null) {
      RecipeDetailsModel? recipeDTLModel;
      add_to_cart.AddToCartResponseData? addToCartResponseModel;
      RecipeModel? recipeModel;
      for (var cartItemEntity in cartItems) {
        if (cartItemEntity != null && cartItemEntity.itemModel.isNotEmpty) {
          final decodedModel = jsonDecode(cartItemEntity.itemModel);
          recipeDTLModel = RecipeDetailsModel.fromJson(decodedModel);
          addToCartResponseModel = add_to_cart.AddToCartResponseData.fromMap(
              jsonDecode(cartItemEntity.orderCreateResponse));
          recipeModel = recipeDTLModel.recipes
              ?.where((p0) => p0.size?.name == cartItemEntity.selectedSize)
              .firstOrNull;
        }
        add_to_cart.OrderDtlWebRequestSet? orderDtlWebRequestFirstItem =
            addToCartResponseModel?.orderDtlWebRequestSet?.first;
        OrderDtlWebRequestSet orderDtlWebRequestSet = OrderDtlWebRequestSet(
          id: orderDtlWebRequestFirstItem?.id,
          recipeMstId: orderDtlWebRequestFirstItem?.recipeMstId,
          qty: orderDtlWebRequestFirstItem?.qty?.ceil(),
          sortOrder: orderDtlWebRequestFirstItem?.sortOrder,
          displayName: orderDtlWebRequestFirstItem?.displayName,
          cookingInstruction: orderDtlWebRequestFirstItem?.cookingInstruction,
          hnhSurcharge: orderDtlWebRequestFirstItem?.hnhSurcharge?.ceil(),
          orderStage: "DS01",
          active: orderDtlWebRequestFirstItem?.active,
          orderRecipeItemWebRequestSet: orderDtlWebRequestFirstItem
                  ?.orderRecipeItemWebRequestSet
                  ?.map((topping) {
                return OrderRecipeItemWebRequestSet(
                  id: topping.id,
                  recipeItemDtlId: recipeModel?.id,
                  qty: topping.qty?.ceil(),
                  defaultQty: topping.defaultQty?.ceil(),
                  sortOrder: topping.sortOrder,
                  base: topping.base,
                );
              }).toList() ??
              [],
        );

        orderDtlWebRequestList.add(orderDtlWebRequestSet);
      }
    }
    payload.orderMstWebRequest?.orderDtlWebRequestSet = orderDtlWebRequestList;
    log("----------------payload-------------------");
    log("${jsonEncode(payload.toJson())}");
    log("----------------payload-------------------");

    ApiResponse? res = await _apiServices.putRequest(
        ApiEndPoints.orderMasterUpdate,
        data: jsonEncode(payload.toJson()));
    // log("response----->${res?.toJson()}");
    if (res != null && res.status) {
    } else {
      showCoomonErrorDialog(title: "error", message: "Something went wrong");
    }
  }
}
