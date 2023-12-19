// To parse this JSON data, do
//
//     final cartTrackingMstCreateModel = cartTrackingMstCreateModelFromJson(jsonString);

import 'dart:convert';

OrderMstUpdatePayload cartTrackingMstCreateModelFromJson(String str) => OrderMstUpdatePayload.fromJson(json.decode(str));

String cartTrackingMstCreateModelToJson(OrderMstUpdatePayload data) => json.encode(data.toJson());

class OrderMstUpdatePayload {
  dynamic orderMst;
  OrderMstWebRequest? orderMstWebRequest;

  OrderMstUpdatePayload({
     this.orderMst,
     this.orderMstWebRequest,
  });

  factory OrderMstUpdatePayload.fromJson(Map<String, dynamic> json) => OrderMstUpdatePayload(
    orderMst: json["orderMST"],
    orderMstWebRequest: OrderMstWebRequest.fromJson(json["orderMSTWebRequest"]),
  );

  Map<String, dynamic> toJson() => {
    "orderMST": orderMst,
    "orderMSTWebRequest": orderMstWebRequest?.toJson(),
  };
}

class OrderMstWebRequest {
  String id;
  int userId;
  String orderType;
  dynamic timedOrder;
  DateTime orderDate;
  dynamic orderTime;
  bool expressOrder;
  String otherInstrucation;
  String deliveyInstrucation;
  CustomerAddressDtl customerAddressDtl;
  String customerName;
  int surcharge;
  int appliedAmount;
  dynamic paymentModeDiscount;
  dynamic paymentModeCharges;
  dynamic promoCodeDiscount;
  String orderStageCode;
  bool active;
  List<OrderDtlWebRequestSet> orderDtlWebRequestSet;
  List<dynamic> paymentModeWebRequestSet;

  OrderMstWebRequest({
    required this.id,
    required this.userId,
    required this.orderType,
    required this.timedOrder,
    required this.orderDate,
    required this.orderTime,
    required this.expressOrder,
    required this.otherInstrucation,
    required this.deliveyInstrucation,
    required this.customerAddressDtl,
    required this.customerName,
    required this.surcharge,
    required this.appliedAmount,
    required this.paymentModeDiscount,
    required this.paymentModeCharges,
    required this.promoCodeDiscount,
    required this.orderStageCode,
    required this.active,
    required this.orderDtlWebRequestSet,
    required this.paymentModeWebRequestSet,
  });

  factory OrderMstWebRequest.fromJson(Map<String, dynamic> json) => OrderMstWebRequest(
    id: json["id"],
    userId: json["userId"],
    orderType: json["orderType"],
    timedOrder: json["timedOrder"],
    orderDate: DateTime.parse(json["orderDate"]),
    orderTime: json["orderTime"],
    expressOrder: json["expressOrder"],
    otherInstrucation: json["otherInstrucation"],
    deliveyInstrucation: json["deliveyInstrucation"],
    customerAddressDtl: CustomerAddressDtl.fromJson(json["customerAddressDTL"]),
    customerName: json["customerName"],
    surcharge: json["surcharge"],
    appliedAmount: json["appliedAmount"],
    paymentModeDiscount: json["paymentModeDiscount"],
    paymentModeCharges: json["paymentModeCharges"],
    promoCodeDiscount: json["promoCodeDiscount"],
    orderStageCode: json["orderStageCode"],
    active: json["active"],
    orderDtlWebRequestSet: List<OrderDtlWebRequestSet>.from(json["orderDTLWebRequestSet"].map((x) => OrderDtlWebRequestSet.fromJson(x))),
    paymentModeWebRequestSet: List<dynamic>.from(json["paymentModeWebRequestSet"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "orderType": orderType,
    "timedOrder": timedOrder,
    "orderDate": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
    "orderTime": orderTime,
    "expressOrder": expressOrder,
    "otherInstrucation": otherInstrucation,
    "deliveyInstrucation": deliveyInstrucation,
    "customerAddressDTL": customerAddressDtl.toJson(),
    "customerName": customerName,
    "surcharge": surcharge,
    "appliedAmount": appliedAmount,
    "paymentModeDiscount": paymentModeDiscount,
    "paymentModeCharges": paymentModeCharges,
    "promoCodeDiscount": promoCodeDiscount,
    "orderStageCode": orderStageCode,
    "active": active,
    "orderDTLWebRequestSet": List<dynamic>.from(orderDtlWebRequestSet.map((x) => x.toJson())),
    "paymentModeWebRequestSet": List<dynamic>.from(paymentModeWebRequestSet.map((x) => x)),
  };
}

class CustomerAddressDtl {
  bool active;
  dynamic address1;
  dynamic address2;
  dynamic customerAddressDtlId;
  dynamic customerAddressTitle;
  dynamic customerMst;
  dynamic customerMstId;
  bool customerAddressDtlDefault;
  dynamic geoLocation;
  int geographyMstId3;
  int geographyMstId4;
  int geographyMstId5;
  String streetNumber;
  dynamic unitNumber;
  dynamic location;
  String pincode;

  CustomerAddressDtl({
    required this.active,
    required this.address1,
    required this.address2,
    required this.customerAddressDtlId,
    required this.customerAddressTitle,
    required this.customerMst,
    required this.customerMstId,
    required this.customerAddressDtlDefault,
    required this.geoLocation,
    required this.geographyMstId3,
    required this.geographyMstId4,
    required this.geographyMstId5,
    required this.streetNumber,
    required this.unitNumber,
    required this.location,
    required this.pincode,
  });

  factory CustomerAddressDtl.fromJson(Map<String, dynamic> json) => CustomerAddressDtl(
    active: json["active"],
    address1: json["address1"],
    address2: json["address2"],
    customerAddressDtlId: json["customerAddressDTLId"],
    customerAddressTitle: json["customerAddressTitle"],
    customerMst: json["customerMST"],
    customerMstId: json["customerMSTId"],
    customerAddressDtlDefault: json["default"],
    geoLocation: json["geoLocation"],
    geographyMstId3: json["geographyMSTId3"],
    geographyMstId4: json["geographyMSTId4"],
    geographyMstId5: json["geographyMSTId5"],
    streetNumber: json["streetNumber"],
    unitNumber: json["unitNumber"],
    location: json["location"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "active": active,
    "address1": address1,
    "address2": address2,
    "customerAddressDTLId": customerAddressDtlId,
    "customerAddressTitle": customerAddressTitle,
    "customerMST": customerMst,
    "customerMSTId": customerMstId,
    "default": customerAddressDtlDefault,
    "geoLocation": geoLocation,
    "geographyMSTId3": geographyMstId3,
    "geographyMSTId4": geographyMstId4,
    "geographyMSTId5": geographyMstId5,
    "streetNumber": streetNumber,
    "unitNumber": unitNumber,
    "location": location,
    "pincode": pincode,
  };
}

class OrderDtlWebRequestSet {
  String id;
  int itemMstId;
  int recipeMstId;
  int itemSide;
  int qty;
  String sortOrder;
  String displayName;
  dynamic cookingInstruction;
  int additionalValue;
  int hnhSurcharge;
  String orderDtlRefId;
  dynamic comboRefId;
  String orderStage;
  bool active;
  List<OrderRecipeItemWebRequestSet> orderRecipeItemWebRequestSet;
  dynamic combSeq;

  OrderDtlWebRequestSet({
    required this.id,
    required this.itemMstId,
    required this.recipeMstId,
    required this.itemSide,
    required this.qty,
    required this.sortOrder,
    required this.displayName,
    required this.cookingInstruction,
    required this.additionalValue,
    required this.hnhSurcharge,
    required this.orderDtlRefId,
    required this.comboRefId,
    required this.orderStage,
    required this.active,
    required this.orderRecipeItemWebRequestSet,
    required this.combSeq,
  });

  factory OrderDtlWebRequestSet.fromJson(Map<String, dynamic> json) => OrderDtlWebRequestSet(
    id: json["id"],
    itemMstId: json["itemMSTId"],
    recipeMstId: json["recipeMSTId"],
    itemSide: json["itemSide"],
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
    orderRecipeItemWebRequestSet: List<OrderRecipeItemWebRequestSet>.from(json["orderRecipeItemWebRequestSet"].map((x) => OrderRecipeItemWebRequestSet.fromJson(x))),
    combSeq: json["combSeq"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "itemMSTId": itemMstId,
    "recipeMSTId": recipeMstId,
    "itemSide": itemSide,
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
    "orderRecipeItemWebRequestSet": List<dynamic>.from(orderRecipeItemWebRequestSet.map((x) => x.toJson())),
    "combSeq": combSeq,
  };
}

class OrderRecipeItemWebRequestSet {
  dynamic id;
  int recipeItemDtlId;
  int qty;
  int defaultQty;
  int itemSide;
  int sortOrder;
  bool base;
  bool active;

  OrderRecipeItemWebRequestSet({
    required this.id,
    required this.recipeItemDtlId,
    required this.qty,
    required this.defaultQty,
    required this.itemSide,
    required this.sortOrder,
    required this.base,
    required this.active,
  });

  factory OrderRecipeItemWebRequestSet.fromJson(Map<String, dynamic> json) => OrderRecipeItemWebRequestSet(
    id: json["id"],
    recipeItemDtlId: json["recipeItemDTLId"],
    qty: json["qty"],
    defaultQty: json["defaultQty"],
    itemSide: json["itemSide"],
    sortOrder: json["sortOrder"],
    base: json["base"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
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
