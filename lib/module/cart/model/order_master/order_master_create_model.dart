// To parse this JSON data, do
//
//     final orderMasterCreateModel = orderMasterCreateModelFromMap(jsonString);

import 'dart:convert';

OrderMasterCreateModel orderMasterCreateModelFromMap(String str) =>
    OrderMasterCreateModel.fromMap(json.decode(str));

String orderMasterCreateModelToMap(OrderMasterCreateModel data) =>
    json.encode(data.toMap());

class OrderMasterCreateModel {
  String? message;
  bool? status;
  Data? data;

  OrderMasterCreateModel({
    this.message,
    this.status,
    this.data,
  });

  factory OrderMasterCreateModel.fromMap(Map<String, dynamic> json) =>
      OrderMasterCreateModel(
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
        orderDate: json["orderDate"] == null
            ? []
            : List<int>.from(json["orderDate"]!.map((x) => x)),
        orderTime: json["orderTime"] == null
            ? []
            : List<int>.from(json["orderTime"]!.map((x) => x)),
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
        orderDtlWebRequestSet: json["orderDTLWebRequestSet"] == null
            ? []
            : List<dynamic>.from(json["orderDTLWebRequestSet"]!.map((x) => x)),
        paymentModeWebRequestSet: json["paymentModeWebRequestSet"] == null
            ? []
            : List<dynamic>.from(
                json["paymentModeWebRequestSet"]!.map((x) => x)),
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
        "orderDate": orderDate == null
            ? []
            : List<dynamic>.from(orderDate!.map((x) => x)),
        "orderTime": orderTime == null
            ? []
            : List<dynamic>.from(orderTime!.map((x) => x)),
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
        "orderDTLWebRequestSet": orderDtlWebRequestSet == null
            ? []
            : List<dynamic>.from(orderDtlWebRequestSet!.map((x) => x)),
        "paymentModeWebRequestSet": paymentModeWebRequestSet == null
            ? []
            : List<dynamic>.from(paymentModeWebRequestSet!.map((x) => x)),
        "orderNumber": orderNumber,
        "cartTrackingPageEnum": cartTrackingPageEnum,
        "remarks": remarks,
        "active": active,
      };
}

CustomerAddressDtl customerAddressDtlFromJson(String str) => CustomerAddressDtl.fromJson(json.decode(str));

String customerAddressDtlToJson(CustomerAddressDtl data) => json.encode(data.toJson());

class CustomerAddressDtl {
  CustomerAddressDtlClass? customerAddressDtl;

  CustomerAddressDtl({
    this.customerAddressDtl,
  });

  factory CustomerAddressDtl.fromJson(Map<String, dynamic> json) => CustomerAddressDtl(
    customerAddressDtl: json["customerAddressDTL"] == null ? null : CustomerAddressDtlClass.fromJson(json["customerAddressDTL"]),
  );

  Map<String, dynamic> toJson() => {
    "customerAddressDTL": customerAddressDtl?.toJson(),
  };
}

class CustomerAddressDtlClass {
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

  CustomerAddressDtlClass({
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

  factory CustomerAddressDtlClass.fromJson(Map<String, dynamic> json) => CustomerAddressDtlClass(
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
