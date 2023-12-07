// To parse this JSON data, do
//
//     final menuItemsModel = menuItemsModelFromMap(jsonString);

import 'dart:convert';

AddToCartPayload menuItemsModelFromMap(String str) => AddToCartPayload.fromMap(json.decode(str));

String menuItemsModelToMap(AddToCartPayload data) => json.encode(data.toMap());

class AddToCartPayload {
  dynamic id;
  int? itemMstId;
  int? recipeMstId;
  int? qty;
  String? sortOrder;
  String? displayName;
  dynamic cookingInstruction;
  int? additionalValue;
  int? hnhSurcharge;
  String? orderDtlRefId;
  dynamic comboRefId;
  String? orderStage;
  bool? active;
  List<OrderRecipeItemWebRequestSet>? orderRecipeItemWebRequestSet;
  dynamic combSeq;
  String? orderMstId;

  AddToCartPayload({
    this.id,
    this.itemMstId,
    this.recipeMstId,
    this.qty,
    this.sortOrder,
    this.displayName,
    this.cookingInstruction,
    this.additionalValue,
    this.hnhSurcharge,
    this.orderDtlRefId,
    this.comboRefId,
    this.orderStage,
    this.active,
    this.orderRecipeItemWebRequestSet,
    this.combSeq,
    this.orderMstId,
  });

  factory AddToCartPayload.fromMap(Map<String, dynamic> json) => AddToCartPayload(
    id: json["id"],
    itemMstId: json["itemMSTId"],
    recipeMstId: json["recipeMSTId"],
    qty: json["qty"],
    sortOrder: json["sortOrder"],
    displayName: json["displayName"],
    cookingInstruction: json["cookingInstruction"],
    additionalValue: json["additionalValue"],
    hnhSurcharge: json["hnhSurcharge"],
    orderDtlRefId: json["orderDTLRefId"],
    comboRefId: json["comboRefId"],
    orderStage: json["orderStage"],
    active: json["active"],
    orderRecipeItemWebRequestSet: json["orderRecipeItemWebRequestSet"] == null ? [] : List<OrderRecipeItemWebRequestSet>.from(json["orderRecipeItemWebRequestSet"]!.map((x) => OrderRecipeItemWebRequestSet.fromMap(x))),
    combSeq: json["combSeq"],
    orderMstId: json["orderMSTId"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "itemMSTId": itemMstId,
    "recipeMSTId": recipeMstId,
    "qty": qty,
    "sortOrder": sortOrder,
    "displayName": displayName,
    "cookingInstruction": cookingInstruction,
    "additionalValue": additionalValue,
    "hnhSurcharge": hnhSurcharge,
    "orderDTLRefId": orderDtlRefId,
    "comboRefId": comboRefId,
    "orderStage": orderStage,
    "active": active,
    "orderRecipeItemWebRequestSet": orderRecipeItemWebRequestSet == null ? [] : List<dynamic>.from(orderRecipeItemWebRequestSet!.map((x) => x.toMap())),
    "combSeq": combSeq,
    "orderMSTId": orderMstId,
  };
}

class OrderRecipeItemWebRequestSet {
  dynamic id;
  int? recipeItemDtlId;
  int? qty;
  int? defaultQty;
  int? sortOrder;
  bool? base;
  bool? active;

  OrderRecipeItemWebRequestSet({
    this.id,
    this.recipeItemDtlId,
    this.qty,
    this.defaultQty,
    this.sortOrder,
    this.base,
    this.active,
  });

  factory OrderRecipeItemWebRequestSet.fromMap(Map<String, dynamic> json) => OrderRecipeItemWebRequestSet(
    id: json["id"],
    recipeItemDtlId: json["recipeItemDTLId"],
    qty: json["qty"],
    defaultQty: json["defaultQty"],
    sortOrder: json["sortOrder"],
    base: json["base"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "recipeItemDTLId": recipeItemDtlId,
    "qty": qty,
    "defaultQty": defaultQty,
    "sortOrder": sortOrder,
    "base": base,
    "active": active,
  };
}
