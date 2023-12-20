import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/widgets/common_dialog.dart';

import '../../../local_storage/entity/cart_items_entity.dart';
import '../../menu/by_group_code/menu_by_group_code_model.dart';
import '../model/order_master/order_master_create_model.dart';
import '../model/order_master/order_mst_update_payload.dart';

class CheckOut extends GetxController {
  static final ApiServices _apiServices = ApiServices();

  static cartUpdate(List<CartItemsEntity?>? cartItems) async {
    OrderMstUpdatePayload payload = OrderMstUpdatePayload();

    final orderMstCreateModel =
        Get.find<OrderMasterCreateModel>(tag: "orderMasterCreateModel");

    payload.orderMstWebRequest?.expressOrder =
        orderMstCreateModel.data?.expressOrder;
    payload.orderMstWebRequest?.active = orderMstCreateModel.data?.active;
    payload.orderMstWebRequest?.id = orderMstCreateModel.data?.id;
    payload.orderMstWebRequest?.customerAddressDtl =
        orderMstCreateModel.data?.customerAddressDtl;
    payload.orderMstWebRequest?.orderDate =
        orderMstCreateModel.data?.orderDate.toString();
    payload.orderMstWebRequest?.orderStageCode =
        orderMstCreateModel.data?.orderStageCode;
    payload.orderMstWebRequest?.otherInstrucation =
        orderMstCreateModel.data?.otherInstrucation;
    payload.orderMstWebRequest?.deliveyInstrucation =
        orderMstCreateModel.data?.deliveyInstrucation;
    payload.orderMstWebRequest?.userId = orderMstCreateModel.data?.userId;
    payload.orderMstWebRequest?.appliedAmount =
        orderMstCreateModel.data?.appliedAmount?.ceil();
    payload.orderMstWebRequest?.customerName =
        orderMstCreateModel.data?.customerName;
    List<OrderDtlWebRequestSet>? orderDtlWebRequestList = [];

    if (cartItems != null) {
      RecipeDetailsModel? recipeDTLModel;
      RecipeModel? recipeModel;
      for (var cartItemEntity in cartItems) {
        if (cartItemEntity != null && cartItemEntity.itemModel.isNotEmpty) {
          final decodedModel = jsonDecode(cartItemEntity.itemModel);
          recipeDTLModel = RecipeDetailsModel.fromJson(decodedModel);
          recipeModel = recipeDTLModel.recipes
              ?.where((p0) => p0.size?.name == cartItemEntity.selectedSize)
              .firstOrNull;
        }

        OrderDtlWebRequestSet orderDtlWebRequestSet = OrderDtlWebRequestSet(
          id: orderMstCreateModel.data?.id,
          recipeMstId: recipeModel?.id,
          qty: cartItemEntity?.itemQuantity,
          sortOrder: "1",
          displayName: recipeDTLModel?.name,
          cookingInstruction: "",
          hnhSurcharge: orderMstCreateModel.data?.surcharge?.ceil(),
          orderStage: orderMstCreateModel.data?.orderStageCode,
          active: recipeDTLModel?.isActive,
          orderRecipeItemWebRequestSet: recipeModel?.toppings?.map((topping) {
                return OrderRecipeItemWebRequestSet(
                  id: topping.id,
                  recipeItemDtlId: recipeModel?.id,
                  qty: topping.itemQuantity?.ceil(),
                  defaultQty: topping.defaultQuantity?.ceil(),
                  sortOrder: 1,
                  base: false,
                );
              }).toList() ??
              [],
        );
        BaseModel? baseModel = recipeModel?.base
            ?.where((base) => base.name == cartItemEntity?.selectedBase)
            .firstOrNull;
        if (baseModel != null) {
          orderDtlWebRequestSet.orderRecipeItemWebRequestSet
              ?.add(OrderRecipeItemWebRequestSet(
            id: baseModel.id,
            recipeItemDtlId: recipeModel?.id,
            qty: baseModel.itemQuantity?.ceil(),
            defaultQty: baseModel.defaultQuantity?.ceil(),
            sortOrder: 1,
            base: true,
          ));
        }
        orderDtlWebRequestList.add(orderDtlWebRequestSet);
      }
    }
    payload.orderMstWebRequest?.orderDtlWebRequestSet = orderDtlWebRequestList;
    log("payload-->${payload.toJson()}");
    ApiResponse? res = await _apiServices
        .putRequest(ApiEndPoints.orderMasterUpdate, data: payload.toJson());
    if (res != null && res.status) {
    } else {
      showCoomonErrorDialog(title: "error", message: "Something went wrong");
    }
  }
}
