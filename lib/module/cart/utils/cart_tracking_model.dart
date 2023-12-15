// To parse this JSON data, do
//
//     final cartTrackingModel = cartTrackingModelFromMap(jsonString);

import 'dart:convert';

CartTrackingModel cartTrackingModelFromMap(String str) => CartTrackingModel.fromMap(json.decode(str));

String cartTrackingModelToMap(CartTrackingModel data) => json.encode(data.toMap());

class CartTrackingModel {
  String? message;
  bool? status;
  Data? data;

  CartTrackingModel({
    this.message,
    this.status,
    this.data,
  });

  factory CartTrackingModel.fromMap(Map<String, dynamic> json) => CartTrackingModel(
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
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  int? cartTrackingMstId;
  String? orderMstId;
  String? initTime;
  String? cartTrackingPage;
  String? menuPageTime;
  String? checkoutTime;
  String? paymentPageTime;
  String? lastPageTime;
  String? cartManageTime;
  bool? active;

  Data({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.cartTrackingMstId,
    this.orderMstId,
    this.initTime,
    this.cartTrackingPage,
    this.menuPageTime,
    this.checkoutTime,
    this.paymentPageTime,
    this.lastPageTime,
    this.cartManageTime,
    this.active,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    createdOn: json["createdOn"],
    modifiedOn: json["modifiedOn"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    cartTrackingMstId: json["cartTrackingMSTId"],
    orderMstId: json["orderMSTId"],
    initTime: json["initTime"],
    cartTrackingPage: json["cartTrackingPage"],
    menuPageTime: json["menuPageTime"],
    checkoutTime: json["checkoutTime"],
    paymentPageTime: json["paymentPageTime"],
    lastPageTime: json["lastPageTime"],
    cartManageTime: json["cartManageTime"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "createdOn": createdOn,
    "modifiedOn": modifiedOn,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "cartTrackingMSTId": cartTrackingMstId,
    "orderMSTId": orderMstId,
    "initTime": initTime,
    "cartTrackingPage": cartTrackingPage,
    "menuPageTime": menuPageTime,
    "checkoutTime": checkoutTime,
    "paymentPageTime": paymentPageTime,
    "lastPageTime": lastPageTime,
    "cartManageTime": cartManageTime,
    "active": active,
  };
}
