// To parse this JSON data, do
//
//     final orderMasterCreatePayload = orderMasterCreatePayloadFromMap(jsonString);

import 'dart:convert';

OrderMasterCreatePayload orderMasterCreatePayloadFromMap(String str) => OrderMasterCreatePayload.fromMap(json.decode(str));

String orderMasterCreatePayloadToMap(OrderMasterCreatePayload data) => json.encode(data.toMap());

class OrderMasterCreatePayload {
  dynamic orderMst;
  OrderMstWebRequest? orderMstWebRequest;

  OrderMasterCreatePayload({
    this.orderMst,
    this.orderMstWebRequest,
  });

  factory OrderMasterCreatePayload.fromMap(Map<String, dynamic> json) => OrderMasterCreatePayload(
    orderMst: json["orderMST"],
    orderMstWebRequest: json["orderMSTWebRequest"] == null ? null : OrderMstWebRequest.fromMap(json["orderMSTWebRequest"]),
  );

  Map<String, dynamic> toMap() => {
    "orderMST": orderMst,
    "orderMSTWebRequest": orderMstWebRequest?.toMap(),
  };
}

class OrderMstWebRequest {
  String? id;
  int? userId;
  String? orderType;
  bool? timedOrder;
  DateTime? orderDate;
  String? orderTime;
  bool? expressOrder;
  String? otherInstrucation;
  String? deliveyInstrucation;
  CustomerAddressDtl? customerAddressDtl;
  String? customerName;
  int? surcharge;
  int? appliedAmount;
  dynamic paymentModeDiscount;
  dynamic paymentModeCharges;
  dynamic promoCodeDiscount;
  String? orderStageCode;
  bool? active;
  List<OrderDtlWebRequestSet>? orderDtlWebRequestSet;
  List<dynamic>? paymentModeWebRequestSet;

  OrderMstWebRequest({
    this.id,
    this.userId,
    this.orderType,
    this.timedOrder,
    this.orderDate,
    this.orderTime,
    this.expressOrder,
    this.otherInstrucation,
    this.deliveyInstrucation,
    this.customerAddressDtl,
    this.customerName,
    this.surcharge,
    this.appliedAmount,
    this.paymentModeDiscount,
    this.paymentModeCharges,
    this.promoCodeDiscount,
    this.orderStageCode,
    this.active,
    this.orderDtlWebRequestSet,
    this.paymentModeWebRequestSet,
  });

  factory OrderMstWebRequest.fromMap(Map<String, dynamic> json) => OrderMstWebRequest(
    id: json["id"],
    userId: json["userId"],
    orderType: json["orderType"],
    timedOrder: json["timedOrder"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    orderTime: json["orderTime"],
    expressOrder: json["expressOrder"],
    otherInstrucation: json["otherInstrucation"],
    deliveyInstrucation: json["deliveyInstrucation"],
    customerAddressDtl: json["customerAddressDTL"] == null ? null : CustomerAddressDtl.fromMap(json["customerAddressDTL"]),
    customerName: json["customerName"],
    surcharge: json["surcharge"],
    appliedAmount: json["appliedAmount"],
    paymentModeDiscount: json["paymentModeDiscount"],
    paymentModeCharges: json["paymentModeCharges"],
    promoCodeDiscount: json["promoCodeDiscount"],
    orderStageCode: json["orderStageCode"],
    active: json["active"],
    orderDtlWebRequestSet: json["orderDTLWebRequestSet"] == null ? [] : List<OrderDtlWebRequestSet>.from(json["orderDTLWebRequestSet"]!.map((x) => OrderDtlWebRequestSet.fromMap(x))),
    paymentModeWebRequestSet: json["paymentModeWebRequestSet"] == null ? [] : List<dynamic>.from(json["paymentModeWebRequestSet"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userId": userId,
    "orderType": orderType,
    "timedOrder": timedOrder,
    "orderDate": "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
    "orderTime": orderTime,
    "expressOrder": expressOrder,
    "otherInstrucation": otherInstrucation,
    "deliveyInstrucation": deliveyInstrucation,
    "customerAddressDTL": customerAddressDtl?.toMap(),
    "customerName": customerName,
    "surcharge": surcharge,
    "appliedAmount": appliedAmount,
    "paymentModeDiscount": paymentModeDiscount,
    "paymentModeCharges": paymentModeCharges,
    "promoCodeDiscount": promoCodeDiscount,
    "orderStageCode": orderStageCode,
    "active": active,
    "orderDTLWebRequestSet": orderDtlWebRequestSet == null ? [] : List<dynamic>.from(orderDtlWebRequestSet!.map((x) => x.toMap())),
    "paymentModeWebRequestSet": paymentModeWebRequestSet == null ? [] : List<dynamic>.from(paymentModeWebRequestSet!.map((x) => x)),
  };
}

class CustomerAddressDtl {
  bool? active;
  dynamic address1;
  dynamic address2;
  dynamic customerAddressDtlId;
  dynamic customerAddressTitle;
  dynamic customerMst;
  dynamic customerMstId;
  bool? customerAddressDtlDefault;
  dynamic geoLocation;
  int? geographyMstId3;
  int? geographyMstId4;
  int? geographyMstId5;
  String? streetNumber;
  String? unitNumber;
  dynamic location;
  String? pincode;

  CustomerAddressDtl({
    this.active,
    this.address1,
    this.address2,
    this.customerAddressDtlId,
    this.customerAddressTitle,
    this.customerMst,
    this.customerMstId,
    this.customerAddressDtlDefault,
    this.geoLocation,
    this.geographyMstId3,
    this.geographyMstId4,
    this.geographyMstId5,
    this.streetNumber,
    this.unitNumber,
    this.location,
    this.pincode,
  });

  factory CustomerAddressDtl.fromMap(Map<String, dynamic> json) => CustomerAddressDtl(
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

  Map<String, dynamic> toMap() => {
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
  String? id;
  int? itemMstId;
  int? recipeMstId;
  int? itemSide;
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

  OrderDtlWebRequestSet({
    this.id,
    this.itemMstId,
    this.recipeMstId,
    this.itemSide,
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
    additionalValue: json["additionalValue"],
    hnhSurcharge: json["hnhSurcharge"],
    orderDtlRefId: json["orderDTLRefId"],
    comboRefId: json["comboRefId"],
    orderStage: json["orderStage"],
    active: json["active"],
    orderRecipeItemWebRequestSet: json["orderRecipeItemWebRequestSet"] == null ? [] : List<OrderRecipeItemWebRequestSet>.from(json["orderRecipeItemWebRequestSet"]!.map((x) => OrderRecipeItemWebRequestSet.fromMap(x))),
    combSeq: json["combSeq"],
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
    "additionalValue": additionalValue,
    "hnhSurcharge": hnhSurcharge,
    "orderDTLRefId": orderDtlRefId,
    "comboRefId": comboRefId,
    "orderStage": orderStage,
    "active": active,
    "orderRecipeItemWebRequestSet": orderRecipeItemWebRequestSet == null ? [] : List<dynamic>.from(orderRecipeItemWebRequestSet!.map((x) => x.toMap())),
    "combSeq": combSeq,
  };
}

class OrderRecipeItemWebRequestSet {
  dynamic id;
  int? recipeItemDtlId;
  int? qty;
  int? defaultQty;
  int? itemSide;
  int? sortOrder;
  bool? base;
  bool? active;

  OrderRecipeItemWebRequestSet({
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
