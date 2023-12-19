// To parse this JSON data, do
//
//     final orderMasterUpdateResponse = orderMasterUpdateResponseFromMap(jsonString);

import 'dart:convert';

OrderMasterUpdateResponse orderMasterUpdateResponseFromMap(String str) => OrderMasterUpdateResponse.fromMap(json.decode(str));

String orderMasterUpdateResponseToMap(OrderMasterUpdateResponse data) => json.encode(data.toMap());

class OrderMasterUpdateResponse {
  String? message;
  bool? status;
  Data? data;

  OrderMasterUpdateResponse({
    this.message,
    this.status,
    this.data,
  });

  factory OrderMasterUpdateResponse.fromMap(Map<String, dynamic> json) => OrderMasterUpdateResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "status": status,
    "data": data?.toMap(),
  };
}

class Data {
  dynamic endTime;
  String? orderAddress;
  dynamic deliveyInstrucation;
  dynamic otherInstrucation;
  String? id;
  String? orderType;
  bool? timedOrder;
  List<int>? orderDate;
  dynamic orderTime;
  dynamic expressOrder;
  dynamic customerMstId;
  dynamic customerAddressDtl;
  dynamic couponMstId;
  dynamic customerName;
  int? surcharge;
  int? appliedAmount;
  dynamic paymentModeDiscount;
  dynamic paymentModeCharges;
  dynamic promoCodeDiscount;
  String? orderStageCode;
  dynamic createdBy;
  dynamic modifiedBy;
  int? userId;
  List<OrderDtlWebRequestSet>? orderDtlWebRequestSet;
  List<dynamic>? paymentModeWebRequestSet;
  String? orderNumber;
  String? cartTrackingPageEnum;
  dynamic remarks;
  bool? active;

  Data({
    this.endTime,
    this.orderAddress,
    this.deliveyInstrucation,
    this.otherInstrucation,
    this.id,
    this.orderType,
    this.timedOrder,
    this.orderDate,
    this.orderTime,
    this.expressOrder,
    this.customerMstId,
    this.customerAddressDtl,
    this.couponMstId,
    this.customerName,
    this.surcharge,
    this.appliedAmount,
    this.paymentModeDiscount,
    this.paymentModeCharges,
    this.promoCodeDiscount,
    this.orderStageCode,
    this.createdBy,
    this.modifiedBy,
    this.userId,
    this.orderDtlWebRequestSet,
    this.paymentModeWebRequestSet,
    this.orderNumber,
    this.cartTrackingPageEnum,
    this.remarks,
    this.active,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    endTime: json["endTime"],
    orderAddress: json["orderAddress"],
    deliveyInstrucation: json["deliveyInstrucation"],
    otherInstrucation: json["otherInstrucation"],
    id: json["id"],
    orderType: json["orderType"],
    timedOrder: json["timedOrder"],
    orderDate: json["orderDate"] == null ? [] : List<int>.from(json["orderDate"]!.map((x) => x)),
    orderTime: json["orderTime"],
    expressOrder: json["expressOrder"],
    customerMstId: json["customerMSTId"],
    customerAddressDtl: json["customerAddressDTL"],
    couponMstId: json["couponMSTId"],
    customerName: json["customerName"],
    surcharge: json["surcharge"],
    appliedAmount: json["appliedAmount"],
    paymentModeDiscount: json["paymentModeDiscount"],
    paymentModeCharges: json["paymentModeCharges"],
    promoCodeDiscount: json["promoCodeDiscount"],
    orderStageCode: json["orderStageCode"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    userId: json["userId"],
    orderDtlWebRequestSet: json["orderDTLWebRequestSet"] == null ? [] : List<OrderDtlWebRequestSet>.from(json["orderDTLWebRequestSet"]!.map((x) => OrderDtlWebRequestSet.fromMap(x))),
    paymentModeWebRequestSet: json["paymentModeWebRequestSet"] == null ? [] : List<dynamic>.from(json["paymentModeWebRequestSet"]!.map((x) => x)),
    orderNumber: json["orderNumber"],
    cartTrackingPageEnum: json["cartTrackingPageEnum"],
    remarks: json["remarks"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "endTime": endTime,
    "orderAddress": orderAddress,
    "deliveyInstrucation": deliveyInstrucation,
    "otherInstrucation": otherInstrucation,
    "id": id,
    "orderType": orderType,
    "timedOrder": timedOrder,
    "orderDate": orderDate == null ? [] : List<dynamic>.from(orderDate!.map((x) => x)),
    "orderTime": orderTime,
    "expressOrder": expressOrder,
    "customerMSTId": customerMstId,
    "customerAddressDTL": customerAddressDtl,
    "couponMSTId": couponMstId,
    "customerName": customerName,
    "surcharge": surcharge,
    "appliedAmount": appliedAmount,
    "paymentModeDiscount": paymentModeDiscount,
    "paymentModeCharges": paymentModeCharges,
    "promoCodeDiscount": promoCodeDiscount,
    "orderStageCode": orderStageCode,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "userId": userId,
    "orderDTLWebRequestSet": orderDtlWebRequestSet == null ? [] : List<dynamic>.from(orderDtlWebRequestSet!.map((x) => x.toMap())),
    "paymentModeWebRequestSet": paymentModeWebRequestSet == null ? [] : List<dynamic>.from(paymentModeWebRequestSet!.map((x) => x)),
    "orderNumber": orderNumber,
    "cartTrackingPageEnum": cartTrackingPageEnum,
    "remarks": remarks,
    "active": active,
  };
}

class OrderDtlWebRequestSet {
  String? id;
  int? itemMstId;
  int? recipeMstId;
  int? itemSide;
  int? qty;
  int? sortOrder;
  dynamic displayName;
  String? cookingInstruction;
  int? hnhSurcharge;
  dynamic additionalValue;
  String? orderDtlRefId;
  dynamic comboRefId;
  dynamic orderMstId;
  dynamic orderStage;
  dynamic combSeq;
  List<OrderRecipeItemWebRequestSet>? orderRecipeItemWebRequestSet;
  bool? active;

  OrderDtlWebRequestSet({
    this.id,
    this.itemMstId,
    this.recipeMstId,
    this.itemSide,
    this.qty,
    this.sortOrder,
    this.displayName,
    this.cookingInstruction,
    this.hnhSurcharge,
    this.additionalValue,
    this.orderDtlRefId,
    this.comboRefId,
    this.orderMstId,
    this.orderStage,
    this.combSeq,
    this.orderRecipeItemWebRequestSet,
    this.active,
  });

  factory OrderDtlWebRequestSet.fromMap(Map<String, dynamic> json) => OrderDtlWebRequestSet(
    id: json["id"],
    itemMstId: json["itemMSTId"],
    recipeMstId: json["recipeMSTId"],
    itemSide: json["itemSide"],
    qty: json["qty"],
    sortOrder: json["sortOrder"],
    displayName: json["displayName"],
    cookingInstruction: json["cookingInstruction"],
    hnhSurcharge: json["hnhSurcharge"],
    additionalValue: json["additionalValue"],
    orderDtlRefId: json["orderDTLRefId"],
    comboRefId: json["comboRefId"],
    orderMstId: json["orderMSTId"],
    orderStage: json["orderStage"],
    combSeq: json["combSeq"],
    orderRecipeItemWebRequestSet: json["orderRecipeItemWebRequestSet"] == null ? [] : List<OrderRecipeItemWebRequestSet>.from(json["orderRecipeItemWebRequestSet"]!.map((x) => OrderRecipeItemWebRequestSet.fromMap(x))),
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "itemMSTId": itemMstId,
    "recipeMSTId": recipeMstId,
    "itemSide": itemSide,
    "qty": qty,
    "sortOrder": sortOrder,
    "displayName": displayName,
    "cookingInstruction": cookingInstruction,
    "hnhSurcharge": hnhSurcharge,
    "additionalValue": additionalValue,
    "orderDTLRefId": orderDtlRefId,
    "comboRefId": comboRefId,
    "orderMSTId": orderMstId,
    "orderStage": orderStage,
    "combSeq": combSeq,
    "orderRecipeItemWebRequestSet": orderRecipeItemWebRequestSet == null ? [] : List<dynamic>.from(orderRecipeItemWebRequestSet!.map((x) => x.toMap())),
    "active": active,
  };
}

class OrderRecipeItemWebRequestSet {
  bool? inFirstFour;
  String? id;
  int? recipeItemDtlId;
  int? qty;
  int? defaultQty;
  int? itemSide;
  int? sortOrder;
  bool? base;
  bool? active;

  OrderRecipeItemWebRequestSet({
    this.inFirstFour,
    this.id,
    this.recipeItemDtlId,
    this.qty,
    this.defaultQty,
    this.itemSide,
    this.sortOrder,
    this.base,
    this.active,
  });

  factory OrderRecipeItemWebRequestSet.fromMap(Map<String, dynamic> json) => OrderRecipeItemWebRequestSet(
    inFirstFour: json["inFirstFour"],
    id: json["id"],
    recipeItemDtlId: json["recipeItemDTLId"],
    qty: json["qty"],
    defaultQty: json["defaultQty"],
    itemSide: json["itemSide"],
    sortOrder: json["sortOrder"],
    base: json["base"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "inFirstFour": inFirstFour,
    "id": id,
    "recipeItemDTLId": recipeItemDtlId,
    "qty": qty,
    "defaultQty": defaultQty,
    "itemSide": itemSide,
    "sortOrder": sortOrder,
    "base": base,
    "active": active,
  };
}
