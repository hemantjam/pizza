// To parse this JSON data, do
//
//     final orderMasterCreateModel = orderMasterCreateModelFromMap(jsonString);

import 'dart:convert';

OrderMasterCreatePayload orderMasterCreateModelFromMap(String str) => OrderMasterCreatePayload.fromMap(json.decode(str));

String orderMasterCreateModelToMap(OrderMasterCreatePayload data) => json.encode(data.toMap());

class OrderMasterCreatePayload {
  OrderMstWebRequest? orderMstWebRequest;
  bool? reOrderStage;

  OrderMasterCreatePayload({
    this.orderMstWebRequest,
    this.reOrderStage,
  });

  factory OrderMasterCreatePayload.fromMap(Map<String, dynamic> json) => OrderMasterCreatePayload(
    orderMstWebRequest: json["orderMSTWebRequest"] == null ? null : OrderMstWebRequest.fromMap(json["orderMSTWebRequest"]),
    reOrderStage: json["reOrderStage"],
  );

  Map<String, dynamic> toMap() => {
    "orderMSTWebRequest": orderMstWebRequest?.toMap(),
    "reOrderStage": reOrderStage,
  };
}

class OrderMstWebRequest {
  bool? active;
  int? appliedAmount;
  String? cartTrackingPageEnum;
  int? couponMstId;
  String? createdBy;
  CustomerAddressDtl? customerAddressDtl;
  String? customerMstId;
  String? customerName;
  String? deliveyInstrucation;
  DateTime? endTime;
  bool? expressOrder;
  String? id;
  String? modifiedBy;
  String? orderAddress;
  String? orderDate;
  String? orderNumber;
  String? orderStageCode;
  String? orderTime;
  String? orderType;
  String? otherInstrucation;
  int? paymentModeCharges;
  int? paymentModeDiscount;
  List<PaymentModeWebRequestSet>? paymentModeWebRequestSet;
  int? promoCodeDiscount;
  String? remarks;
  int? surcharge;
  bool? timedOrder;
  int? userId;

  OrderMstWebRequest({
    this.active,
    this.appliedAmount,
    this.cartTrackingPageEnum,
    this.couponMstId,
    this.createdBy,
    this.customerAddressDtl,
    this.customerMstId,
    this.customerName,
    this.deliveyInstrucation,
    this.endTime,
    this.expressOrder,
    this.id,
    this.modifiedBy,
    this.orderAddress,
    this.orderDate,
    this.orderNumber,
    this.orderStageCode,
    this.orderTime,
    this.orderType,
    this.otherInstrucation,
    this.paymentModeCharges,
    this.paymentModeDiscount,
    this.paymentModeWebRequestSet,
    this.promoCodeDiscount,
    this.remarks,
    this.surcharge,
    this.timedOrder,
    this.userId,
  });

  factory OrderMstWebRequest.fromMap(Map<String, dynamic> json) => OrderMstWebRequest(
    active: json["active"],
    appliedAmount: json["appliedAmount"],
    cartTrackingPageEnum: json["cartTrackingPageEnum"],
    couponMstId: json["couponMSTId"],
    createdBy: json["createdBy"],
    customerAddressDtl: json["customerAddressDTL"] == null ? null : CustomerAddressDtl.fromMap(json["customerAddressDTL"]),
    customerMstId: json["customerMSTId"],
    customerName: json["customerName"],
    deliveyInstrucation: json["deliveyInstrucation"],
    endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
    expressOrder: json["expressOrder"],
    id: json["id"],
    modifiedBy: json["modifiedBy"],
    orderAddress: json["orderAddress"],
    orderDate: json["orderDate"] ,
    orderNumber: json["orderNumber"],
    orderStageCode: json["orderStageCode"],
    orderTime: json["orderTime"],
    orderType: json["orderType"],
    otherInstrucation: json["otherInstrucation"],
    paymentModeCharges: json["paymentModeCharges"],
    paymentModeDiscount: json["paymentModeDiscount"],
    paymentModeWebRequestSet: json["paymentModeWebRequestSet"] == null ? [] : List<PaymentModeWebRequestSet>.from(json["paymentModeWebRequestSet"]!.map((x) => PaymentModeWebRequestSet.fromMap(x))),
    promoCodeDiscount: json["promoCodeDiscount"],
    remarks: json["remarks"],
    surcharge: json["surcharge"],
    timedOrder: json["timedOrder"],
    userId: json["userId"],
  );

  Map<String, dynamic> toMap() => {
    "active": active,
    "appliedAmount": appliedAmount,
    "cartTrackingPageEnum": cartTrackingPageEnum,
    "couponMSTId": couponMstId,
    "createdBy": createdBy,
    "customerAddressDTL": customerAddressDtl?.toMap(),
    "customerMSTId": customerMstId,
    "customerName": customerName,
    "deliveyInstrucation": deliveyInstrucation,
    "endTime": endTime?.toIso8601String(),
    "expressOrder": expressOrder,
    "id": id,
    "modifiedBy": modifiedBy,
    "orderAddress": orderAddress,
    "orderDate": orderDate,
    "orderNumber": orderNumber,
    "orderStageCode": orderStageCode,
    "orderTime": orderTime,
    "orderType": orderType,
    "otherInstrucation": otherInstrucation,
    "paymentModeCharges": paymentModeCharges,
    "paymentModeDiscount": paymentModeDiscount,
    "paymentModeWebRequestSet": paymentModeWebRequestSet == null ? [] : List<dynamic>.from(paymentModeWebRequestSet!.map((x) => x.toMap())),
    "promoCodeDiscount": promoCodeDiscount,
    "remarks": remarks,
    "surcharge": surcharge,
    "timedOrder": timedOrder,
    "userId": userId,
  };
}

class CustomerAddressDtl {
  bool? active;
  String? address1;
  String? address2;
  String? createdBy;
  String? createdOn;
  String? customerAddressDtlId;
  String? customerAddressTitle;
  CustomerMst? customerMst;
  String? customerMstId;
  bool? customerAddressDtlDefault;
  String? deliveryInstruction;
  String? geoLocation;
  int? geographyMstId1;
  int? geographyMstId2;
  int? geographyMstId3;
  int? geographyMstId4;
  int? geographyMstId5;
  int? geographyMstId6;
  int? geographyMstId7;
  int? geographyMstId8;
  String? location;
  String? modifiedBy;
  String? modifiedOn;
  int? pincode;
  String? streetNumber;
  String? unitNumber;

  CustomerAddressDtl({
    this.active,
    this.address1,
    this.address2,
    this.createdBy,
    this.createdOn,
    this.customerAddressDtlId,
    this.customerAddressTitle,
    this.customerMst,
    this.customerMstId,
    this.customerAddressDtlDefault,
    this.deliveryInstruction,
    this.geoLocation,
    this.geographyMstId1,
    this.geographyMstId2,
    this.geographyMstId3,
    this.geographyMstId4,
    this.geographyMstId5,
    this.geographyMstId6,
    this.geographyMstId7,
    this.geographyMstId8,
    this.location,
    this.modifiedBy,
    this.modifiedOn,
    this.pincode,
    this.streetNumber,
    this.unitNumber,
  });

  factory CustomerAddressDtl.fromMap(Map<String, dynamic> json) => CustomerAddressDtl(
    active: json["active"],
    address1: json["address1"],
    address2: json["address2"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] ,
    customerAddressDtlId: json["customerAddressDTLId"],
    customerAddressTitle: json["customerAddressTitle"],
    customerMst: json["customerMST"] == null ? null : CustomerMst.fromMap(json["customerMST"]),
    customerMstId: json["customerMSTId"],
    customerAddressDtlDefault: json["default"],
    deliveryInstruction: json["deliveryInstruction"],
    geoLocation: json["geoLocation"],
    geographyMstId1: json["geographyMSTId1"],
    geographyMstId2: json["geographyMSTId2"],
    geographyMstId3: json["geographyMSTId3"],
    geographyMstId4: json["geographyMSTId4"],
    geographyMstId5: json["geographyMSTId5"],
    geographyMstId6: json["geographyMSTId6"],
    geographyMstId7: json["geographyMSTId7"],
    geographyMstId8: json["geographyMSTId8"],
    location: json["location"],
    modifiedBy: json["modifiedBy"],
    modifiedOn: json["modifiedOn"],
    pincode: json["pincode"],
    streetNumber: json["streetNumber"],
    unitNumber: json["unitNumber"],
  );

  Map<String, dynamic> toMap() => {
    "active": active,
    "address1": address1,
    "address2": address2,
    "createdBy": createdBy,
    "createdOn": createdOn,
    "customerAddressDTLId": customerAddressDtlId,
    "customerAddressTitle": customerAddressTitle,
    "customerMST": customerMst?.toMap(),
    "customerMSTId": customerMstId,
    "default": customerAddressDtlDefault,
    "deliveryInstruction": deliveryInstruction,
    "geoLocation": geoLocation,
    "geographyMSTId1": geographyMstId1,
    "geographyMSTId2": geographyMstId2,
    "geographyMSTId3": geographyMstId3,
    "geographyMSTId4": geographyMstId4,
    "geographyMSTId5": geographyMstId5,
    "geographyMSTId6": geographyMstId6,
    "geographyMSTId7": geographyMstId7,
    "geographyMSTId8": geographyMstId8,
    "location": location,
    "modifiedBy": modifiedBy,
    "modifiedOn": modifiedOn,
    "pincode": pincode,
    "streetNumber": streetNumber,
    "unitNumber": unitNumber,
  };
}

class CustomerMst {
  bool? active;
  bool? aggregator;
  String? anniversary;
  String? birthDate;
  String? createdBy;
  String? createdOn;
  List<CustomerAddressDtlList>? customerAddressDtlList;
  String? customerCode;
  String? customerFirstName;
  int? customerGroupMstId;
  String? customerLastName;
  String? customerMstId;
  bool? emailSubscription;
  int? gender;
  int? ledgerBalance;
  String? modifiedBy;
  String? modifiedOn;
  String? primaryContact;
  String? primaryEmail;
  bool? smsSubscription;
  String? storeInstruction;
  int? userMstId;

  CustomerMst({
    this.active,
    this.aggregator,
    this.anniversary,
    this.birthDate,
    this.createdBy,
    this.createdOn,
    this.customerAddressDtlList,
    this.customerCode,
    this.customerFirstName,
    this.customerGroupMstId,
    this.customerLastName,
    this.customerMstId,
    this.emailSubscription,
    this.gender,
    this.ledgerBalance,
    this.modifiedBy,
    this.modifiedOn,
    this.primaryContact,
    this.primaryEmail,
    this.smsSubscription,
    this.storeInstruction,
    this.userMstId,
  });

  factory CustomerMst.fromMap(Map<String, dynamic> json) => CustomerMst(
    active: json["active"],
    aggregator: json["aggregator"],
    anniversary: json["anniversary"] ,
    birthDate: json["birthDate"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"],
    customerAddressDtlList: json["customerAddressDTLList"] == null ? [] : List<CustomerAddressDtlList>.from(json["customerAddressDTLList"]!.map((x) => CustomerAddressDtlList.fromMap(x))),
    customerCode: json["customerCode"],
    customerFirstName: json["customerFirstName"],
    customerGroupMstId: json["customerGroupMSTId"],
    customerLastName: json["customerLastName"],
    customerMstId: json["customerMSTId"],
    emailSubscription: json["emailSubscription"],
    gender: json["gender"],
    ledgerBalance: json["ledgerBalance"],
    modifiedBy: json["modifiedBy"],
    modifiedOn: json["modifiedOn"],
    primaryContact: json["primaryContact"],
    primaryEmail: json["primaryEmail"],
    smsSubscription: json["smsSubscription"],
    storeInstruction: json["storeInstruction"],
    userMstId: json["userMSTId"],
  );

  Map<String, dynamic> toMap() => {
    "active": active,
    "aggregator": aggregator,
    "anniversary":anniversary,
    "birthDate": birthDate,
    "createdBy": createdBy,
    "createdOn": createdOn,
    "customerAddressDTLList": customerAddressDtlList == null ? [] : List<dynamic>.from(customerAddressDtlList!.map((x) => x.toMap())),
    "customerCode": customerCode,
    "customerFirstName": customerFirstName,
    "customerGroupMSTId": customerGroupMstId,
    "customerLastName": customerLastName,
    "customerMSTId": customerMstId,
    "emailSubscription": emailSubscription,
    "gender": gender,
    "ledgerBalance": ledgerBalance,
    "modifiedBy": modifiedBy,
    "modifiedOn": modifiedOn,
    "primaryContact": primaryContact,
    "primaryEmail": primaryEmail,
    "smsSubscription": smsSubscription,
    "storeInstruction": storeInstruction,
    "userMSTId": userMstId,
  };
}

class CustomerAddressDtlList {
  CustomerAddressDtlList();

  factory CustomerAddressDtlList.fromMap(Map<String, dynamic> json) => CustomerAddressDtlList(
  );

  Map<String, dynamic> toMap() => {
  };
}

class PaymentModeWebRequestSet {
  bool? active;
  int? amount;
  String? id;
  int? paymentModeMstId;
  String? paymentReference;
  bool? status;

  PaymentModeWebRequestSet({
    this.active,
    this.amount,
    this.id,
    this.paymentModeMstId,
    this.paymentReference,
    this.status,
  });

  factory PaymentModeWebRequestSet.fromMap(Map<String, dynamic> json) => PaymentModeWebRequestSet(
    active: json["active"],
    amount: json["amount"],
    id: json["id"],
    paymentModeMstId: json["paymentModeMSTId"],
    paymentReference: json["paymentReference"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "active": active,
    "amount": amount,
    "id": id,
    "paymentModeMSTId": paymentModeMstId,
    "paymentReference": paymentReference,
    "status": status,
  };
}
