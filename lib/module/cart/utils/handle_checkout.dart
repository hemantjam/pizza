import 'dart:convert';

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
        OrderMSTUpdatePayloadCustomerAddressDtl(
            active: true,
            address1: null,
            address2: null,
            customerAddressDtlId: null,
            customerAddressTitle: null,
            customerMst: null,
            customerMstId: null,
            customerAddressDtlDefault: true,
            geoLocation: null,
            geographyMstId3: 1008,
            geographyMstId4: 327,
            geographyMstId5: 328,
            streetNumber: "00",
            unitNumber: "00",
            location: null,
            pincode: "3040");
    payload.orderMstWebRequest?.customerName = "";
    payload.orderMstWebRequest?.surcharge = 0;

    payload.orderMstWebRequest?.orderDate = "2023-12-22";
    payload.orderMstWebRequest?.orderStageCode = "DS01";
    payload.orderMstWebRequest?.otherInstrucation = "";
    payload.orderMstWebRequest?.deliveyInstrucation = "";
    payload.orderMstWebRequest?.userId = orderMstCreateModel.data?.userId;
    payload.orderMstWebRequest?.appliedAmount = 0;

    List<OrderDtlWebRequestSet>? orderDtlWebRequestList = [];
    if (cartItems != null) {
      RecipeDetailsModel? recipeDTLModel;
      add_to_cart.AddToCartResponseData? addToCartResponseModel;
      cartItems.asMap().forEach((key, cItem) {
        if (cItem != null && cItem.itemModel.isNotEmpty) {
          final decodedModel = jsonDecode(cItem.itemModel);
          recipeDTLModel = RecipeDetailsModel.fromJson(decodedModel);
          addToCartResponseModel = add_to_cart.AddToCartResponseData.fromMap(
              jsonDecode(cItem.orderCreateResponse));
          /* recipeModel = recipeDTLModel?.recipes
              ?.where((rModel) => rModel.size?.name == cItem.selectedSize)
              .firstOrNull;*/
          /* BaseModel? baseModel = recipeDTLModel?.recipes
              ?.where((bModel) => bModel.size?.name == cItem.selectedSize)
              .first
              .base
              ?.where((elementtt) => elementtt?.name == cItem.selectedBase)
              .firstOrNull;*/
          /* if (baseModel != null) {
            recipeModel?.toppings?.add(ToppingsModel(
                name: baseModel.name,
                stockAvailable: baseModel.stockAvailable,
                image: baseModel.image,
                id: baseModel.id,
                addCost: baseModel.addCost,
                defaultQuantity: baseModel.defaultQuantity,
                itemQuantity: baseModel.itemQuantity,
                minimumQuantity: baseModel.minimumQuantity,
                maximumQuantity: baseModel.maximumQuantity));
            recipeModel?.toppings?.add(ToppingsModel(
                name: baseModel.name,
                stockAvailable: baseModel.stockAvailable,
                image: baseModel.image,
                id: baseModel.id,
                addCost: baseModel.addCost,
                defaultQuantity: baseModel.defaultQuantity,
                itemQuantity: baseModel.itemQuantity,
                minimumQuantity: baseModel.minimumQuantity,
                maximumQuantity: baseModel.maximumQuantity));
          }*/
        }

        add_to_cart.OrderDtlWebRequestSet? orderDtlWebRequestFirstItem =
            addToCartResponseModel?.orderDtlWebRequestSet?.first;
        OrderDtlWebRequestSet orderDtlWebRequestSet = OrderDtlWebRequestSet(
          itemMstId: orderDtlWebRequestFirstItem?.itemMstId,
          id: orderDtlWebRequestFirstItem?.id,
          orderDtlRefId: orderDtlWebRequestFirstItem?.id,
          recipeMstId: orderDtlWebRequestFirstItem?.recipeMstId,
          qty: orderDtlWebRequestFirstItem?.qty?.ceil(),
          sortOrder: orderDtlWebRequestFirstItem?.sortOrder,
          itemSide: 0,
          displayName: recipeDTLModel?.name,
          cookingInstruction: orderDtlWebRequestFirstItem?.cookingInstruction,
          hnhSurcharge: orderDtlWebRequestFirstItem?.hnhSurcharge?.ceil(),
          orderStage: "DS01",
          additionalValue: 0,
          active: true,
          orderRecipeItemWebRequestSet: orderDtlWebRequestFirstItem
                  ?.orderRecipeItemWebRequestSet
                  ?.asMap()
                  .entries
                  .map((topping) {
                return OrderRecipeItemWebRequestSet(
                    recipeItemDtlId: topping.value.recipeItemDtlId,
                    qty: topping.value.qty?.ceil(),
                    defaultQty: topping.value.defaultQty?.ceil(),
                    sortOrder: topping.key,
                    base: topping.value.base,
                    active: topping.value.active,
                    itemSide: topping.value.itemSide);
              }).toList() ??
              [],
        );

        orderDtlWebRequestList.add(orderDtlWebRequestSet);
      });
    }
    payload.orderMstWebRequest?.orderDtlWebRequestSet = orderDtlWebRequestList;
    ApiResponse? res = await _apiServices.putRequest(
        ApiEndPoints.orderMasterUpdate,
        data: jsonEncode(payload.toJson()));
    if (res != null && res.status) {
    } else {
      showCoomonErrorDialog(title: "error", message: "Something went wrong");
    }
  }
}
