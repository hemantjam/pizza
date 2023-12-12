// To parse this JSON data, do
//
//     final orderMasterCreateModel = orderMasterCreateModelFromMap(jsonString);

import 'dart:convert';

OrderMasterCreateModel orderMasterCreateModelFromMap(String str) => OrderMasterCreateModel.fromMap(json.decode(str));

String orderMasterCreateModelToMap(OrderMasterCreateModel data) => json.encode(data.toMap());

class OrderMasterCreateModel {
  String? message;
  bool? status;
  Data? data;

  OrderMasterCreateModel({
    this.message,
    this.status,
    this.data,
  });

  factory OrderMasterCreateModel.fromMap(Map<String, dynamic> json) => OrderMasterCreateModel(
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
  dynamic orderAddress;
  dynamic deliveyInstrucation;
  dynamic otherInstrucation;
  String? id;
  String? orderType;
  bool? timedOrder;
  List<int>? orderDate;
  List<int>? orderTime;
  dynamic expressOrder;
  dynamic customerMstId;
  dynamic customerAddressDtl;
  dynamic couponMstId;
  dynamic customerName;
  double? surcharge;
  double? appliedAmount;
  dynamic paymentModeDiscount;
  dynamic paymentModeCharges;
  dynamic promoCodeDiscount;
  String? orderStageCode;
  dynamic createdBy;
  dynamic modifiedBy;
  int? userId;
  List<dynamic>? orderDtlWebRequestSet;
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
    orderTime: json["orderTime"] == null ? [] : List<int>.from(json["orderTime"]!.map((x) => x)),
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
    orderDtlWebRequestSet: json["orderDTLWebRequestSet"] == null ? [] : List<dynamic>.from(json["orderDTLWebRequestSet"]!.map((x) => x)),
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
    "orderTime": orderTime == null ? [] : List<dynamic>.from(orderTime!.map((x) => x)),
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
    "orderDTLWebRequestSet": orderDtlWebRequestSet == null ? [] : List<dynamic>.from(orderDtlWebRequestSet!.map((x) => x)),
    "paymentModeWebRequestSet": paymentModeWebRequestSet == null ? [] : List<dynamic>.from(paymentModeWebRequestSet!.map((x) => x)),
    "orderNumber": orderNumber,
    "cartTrackingPageEnum": cartTrackingPageEnum,
    "remarks": remarks,
    "active": active,
  };
}
