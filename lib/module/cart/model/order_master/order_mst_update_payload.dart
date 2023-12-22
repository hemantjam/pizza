// To parse this JSON data, do
//
//     final cartTrackingMstCreateModel = cartTrackingMstCreateModelFromJson(jsonString?);

import 'dart:convert';

OrderMstUpdatePayload cartTrackingMstCreateModelFromJson(String? str) =>
    OrderMstUpdatePayload.fromJson(json.decode(str!));

String? cartTrackingMstCreateModelToJson(OrderMstUpdatePayload data) =>
    json.encode(data.toJson());

class OrderMstUpdatePayload {
  dynamic orderMst;
  OrderMstWebRequest? orderMstWebRequest;

  OrderMstUpdatePayload({
    this.orderMst,
    this.orderMstWebRequest,
  }) {
    orderMstWebRequest ??= OrderMstWebRequest(); // Set a default value if null
  }

  factory OrderMstUpdatePayload.fromJson(Map<String?, dynamic> json) =>
      OrderMstUpdatePayload(
        orderMst: json["orderMST"],
        orderMstWebRequest:
            OrderMstWebRequest.fromJson(json["orderMSTWebRequest"]),
      );

  Map<String?, dynamic> toJson() => {
        "orderMST": orderMst,
        "orderMSTWebRequest": orderMstWebRequest?.toJson(),
      };
}

class OrderMstWebRequest {
  String? id;
  int? userId;
  String? orderType;
  bool? timedOrder;
  String? orderDate;
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

  factory OrderMstWebRequest.fromJson(Map<String?, dynamic> json) =>
      OrderMstWebRequest(
        id: json["id"],
        userId: json["userId"],
        orderType: json["orderType"],
        timedOrder: json["timedOrder"],
        orderDate: json["orderDate"],
        orderTime: json["orderTime"],
        expressOrder: json["expressOrder"],
        otherInstrucation: json["otherInstrucation"],
        deliveyInstrucation: json["deliveyInstrucation"],
        customerAddressDtl:
            CustomerAddressDtl.fromJson(json["customerAddressDTL"]),
        customerName: json["customerName"],
        surcharge: json["surcharge"],
        appliedAmount: json["appliedAmount"],
        paymentModeDiscount: json["paymentModeDiscount"],
        paymentModeCharges: json["paymentModeCharges"],
        promoCodeDiscount: json["promoCodeDiscount"],
        orderStageCode: json["orderStageCode"],
        active: json["active"],
        orderDtlWebRequestSet: List<OrderDtlWebRequestSet>.from(
            json["orderDTLWebRequestSet"]
                .map((x) => OrderDtlWebRequestSet.fromJson(x))),
        paymentModeWebRequestSet:
            List<dynamic>.from(json["paymentModeWebRequestSet"].map((x) => x)),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "orderType": orderType,
        "timedOrder": timedOrder,
        "orderDate": orderDate,
        "orderTime": orderTime,
        "expressOrder": expressOrder,
        "otherInstrucation": otherInstrucation,
        "deliveyInstrucation": deliveyInstrucation,
        "customerAddressDTL": customerAddressDtl?.toJson(),
        "customerName": customerName,
        "surcharge": surcharge,
        "appliedAmount": appliedAmount,
        "paymentModeDiscount": paymentModeDiscount,
        "paymentModeCharges": paymentModeCharges,
        "promoCodeDiscount": promoCodeDiscount,
        "orderStageCode": orderStageCode,
        "active": active,
        "orderDTLWebRequestSet": List<dynamic>.from(
            orderDtlWebRequestSet?.map((x) => x.toJson()) ?? []),
        "paymentModeWebRequestSet":
            List<dynamic>.from(paymentModeWebRequestSet?.map((x) => x) ?? []),
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
  dynamic unitNumber;
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

  factory CustomerAddressDtl.fromJson(Map<String?, dynamic> json) =>
      CustomerAddressDtl(
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

  Map<String?, dynamic> toJson() => {
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

  factory OrderDtlWebRequestSet.fromJson(Map<String?, dynamic> json) =>
      OrderDtlWebRequestSet(
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
        orderRecipeItemWebRequestSet: List<OrderRecipeItemWebRequestSet>.from(
            json["orderRecipeItemWebRequestSet"]
                .map((x) => OrderRecipeItemWebRequestSet.fromJson(x))),
        combSeq: json["combSeq"],
      );

  Map<String?, dynamic> toJson() => {
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
        "orderRecipeItemWebRequestSet": List<dynamic>.from(
            orderRecipeItemWebRequestSet!.map((x) => x.toJson())),
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

  factory OrderRecipeItemWebRequestSet.fromJson(Map<String?, dynamic> json) =>
      OrderRecipeItemWebRequestSet(
        id: json["id"],
        recipeItemDtlId: json["recipeItemDtlId"],
        // Corrected key here
        qty: json["qty"],
        defaultQty: json["defaultQty"],
        itemSide: json["itemSide"],
        sortOrder: json["sortOrder"],
        base: json["base"],
        active: json["active"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "recipeItemDtlId": recipeItemDtlId, // Corrected key here
        "qty": qty,
        "defaultQty": defaultQty,
        "itemSide": itemSide,
        "sortOrder": sortOrder,
        "base": base,
        "active": active,
      };
}
