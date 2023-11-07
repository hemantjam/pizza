import 'dart:convert';

class OutletModel {
  String? message;
  bool? status;
  Data? data;

  OutletModel({
    this.message,
    this.status,
    this.data,
  });

  factory OutletModel.fromRawJson(String str) => OutletModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OutletModel.fromJson(Map<String, dynamic> json) => OutletModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  DateTime? createdOn;
  DateTime? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  int? outletMstId;
  String? outletCode;
  String? outletName;
  int? outletTypeMstId;
  int? outletGroupMstId;
  int? outletCategoryMstId;
  dynamic parentOutletMstId;
  dynamic groupOutletMstId;
  dynamic logoSmall;
  dynamic logoBig;
  String? ownerName;
  int? gender;
  DateTime? birthDate;
  dynamic anniversary;
  String? primaryEmail;
  String? secondaryEmail;
  String? primaryContact;
  String? secondaryContact;
  String? webSite;
  DateTime? registrationNumber;
  DateTime? registrationDate;
  dynamic registrationValidityDate;
  String? address1;
  String? address2;
  String? location;
  String? geoLocation;
  int? pincode;
  int? geographyMstId1;
  GeographyMst1? geographyMst1;
  int? geographyMstId2;
  GeographyMst1? geographyMst2;
  int? geographyMstId3;
  GeographyMst1? geographyMst3;
  int? geographyMstId4;
  GeographyMst1? geographyMst4;
  int? geographyMstId5;
  GeographyMst1? geographyMst5;
  int? geographyMstId6;
  GeographyMst1? geographyMst6;
  int? geographyMstId7;
  GeographyMst1? geographyMst7;
  int? geographyMstId8;
  GeographyMst1? geographyMst8;
  dynamic polygon;
  int? extraHours;
  String? purchasePriceListMstId;
  String? salesPriceListMstId;
  String? transferPriceListMstId;
  int? salesTaxCodeMstId;
  String? taxMessage;
  String? termCondition;
  String? legalInformation;
  String? thanksNotes;
  String? customerCare;
  String? abnNumber;
  int? driverFloatAmount;
  int? dayStartFloatAmount;
  List<SurchargeDtlList>? surchargeDtlList;
  List<DocumentStagesList>? documentStagesList;
  bool? active;

  Data({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.outletMstId,
    this.outletCode,
    this.outletName,
    this.outletTypeMstId,
    this.outletGroupMstId,
    this.outletCategoryMstId,
    this.parentOutletMstId,
    this.groupOutletMstId,
    this.logoSmall,
    this.logoBig,
    this.ownerName,
    this.gender,
    this.birthDate,
    this.anniversary,
    this.primaryEmail,
    this.secondaryEmail,
    this.primaryContact,
    this.secondaryContact,
    this.webSite,
    this.registrationNumber,
    this.registrationDate,
    this.registrationValidityDate,
    this.address1,
    this.address2,
    this.location,
    this.geoLocation,
    this.pincode,
    this.geographyMstId1,
    this.geographyMst1,
    this.geographyMstId2,
    this.geographyMst2,
    this.geographyMstId3,
    this.geographyMst3,
    this.geographyMstId4,
    this.geographyMst4,
    this.geographyMstId5,
    this.geographyMst5,
    this.geographyMstId6,
    this.geographyMst6,
    this.geographyMstId7,
    this.geographyMst7,
    this.geographyMstId8,
    this.geographyMst8,
    this.polygon,
    this.extraHours,
    this.purchasePriceListMstId,
    this.salesPriceListMstId,
    this.transferPriceListMstId,
    this.salesTaxCodeMstId,
    this.taxMessage,
    this.termCondition,
    this.legalInformation,
    this.thanksNotes,
    this.customerCare,
    this.abnNumber,
    this.driverFloatAmount,
    this.dayStartFloatAmount,
    this.surchargeDtlList,
    this.documentStagesList,
    this.active,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    outletMstId: json["outletMSTId"],
    outletCode: json["outletCode"],
    outletName: json["outletName"],
    outletTypeMstId: json["outletTypeMSTId"],
    outletGroupMstId: json["outletGroupMSTId"],
    outletCategoryMstId: json["outletCategoryMSTId"],
    parentOutletMstId: json["parentOutletMSTId"],
    groupOutletMstId: json["groupOutletMSTId"],
    logoSmall: json["logoSmall"],
    logoBig: json["logoBig"],
    ownerName: json["ownerName"],
    gender: json["gender"],
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    anniversary: json["anniversary"],
    primaryEmail: json["primaryEmail"],
    secondaryEmail: json["secondaryEmail"],
    primaryContact: json["primaryContact"],
    secondaryContact: json["secondaryContact"],
    webSite: json["webSite"],
    registrationNumber: json["registrationNumber"] == null ? null : DateTime.parse(json["registrationNumber"]),
    registrationDate: json["registrationDate"] == null ? null : DateTime.parse(json["registrationDate"]),
    registrationValidityDate: json["registrationValidityDate"],
    address1: json["address1"],
    address2: json["address2"],
    location: json["location"],
    geoLocation: json["geoLocation"],
    pincode: json["pincode"],
    geographyMstId1: json["geographyMSTId1"],
    geographyMst1: json["geographyMST1"] == null ? null : GeographyMst1.fromJson(json["geographyMST1"]),
    geographyMstId2: json["geographyMSTId2"],
    geographyMst2: json["geographyMST2"] == null ? null : GeographyMst1.fromJson(json["geographyMST2"]),
    geographyMstId3: json["geographyMSTId3"],
    geographyMst3: json["geographyMST3"] == null ? null : GeographyMst1.fromJson(json["geographyMST3"]),
    geographyMstId4: json["geographyMSTId4"],
    geographyMst4: json["geographyMST4"] == null ? null : GeographyMst1.fromJson(json["geographyMST4"]),
    geographyMstId5: json["geographyMSTId5"],
    geographyMst5: json["geographyMST5"] == null ? null : GeographyMst1.fromJson(json["geographyMST5"]),
    geographyMstId6: json["geographyMSTId6"],
    geographyMst6: json["geographyMST6"] == null ? null : GeographyMst1.fromJson(json["geographyMST6"]),
    geographyMstId7: json["geographyMSTId7"],
    geographyMst7: json["geographyMST7"],
    geographyMstId8: json["geographyMSTId8"],
    geographyMst8: json["geographyMST8"],
    polygon: json["polygon"],
    extraHours: json["extraHours"],
    purchasePriceListMstId: json["purchasePriceListMSTId"],
    salesPriceListMstId: json["salesPriceListMSTId"],
    transferPriceListMstId: json["transferPriceListMSTId"],
    salesTaxCodeMstId: json["salesTaxCodeMSTId"],
    taxMessage: json["taxMessage"],
    termCondition: json["termCondition"],
    legalInformation: json["legalInformation"],
    thanksNotes: json["thanksNotes"],
    customerCare: json["customerCare"],
    abnNumber: json["abnNumber"],
    driverFloatAmount: json["driverFloatAmount"],
    dayStartFloatAmount: json["dayStartFloatAmount"],
    surchargeDtlList: json["surchargeDTLList"] == null ? [] : List<SurchargeDtlList>.from(json["surchargeDTLList"]!.map((x) => SurchargeDtlList.fromJson(x))),
    documentStagesList: json["documentStagesList"] == null ? [] : List<DocumentStagesList>.from(json["documentStagesList"]!.map((x) => DocumentStagesList.fromJson(x))),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "outletMSTId": outletMstId,
    "outletCode": outletCode,
    "outletName": outletName,
    "outletTypeMSTId": outletTypeMstId,
    "outletGroupMSTId": outletGroupMstId,
    "outletCategoryMSTId": outletCategoryMstId,
    "parentOutletMSTId": parentOutletMstId,
    "groupOutletMSTId": groupOutletMstId,
    "logoSmall": logoSmall,
    "logoBig": logoBig,
    "ownerName": ownerName,
    "gender": gender,
    "birthDate": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "anniversary": anniversary,
    "primaryEmail": primaryEmail,
    "secondaryEmail": secondaryEmail,
    "primaryContact": primaryContact,
    "secondaryContact": secondaryContact,
    "webSite": webSite,
    "registrationNumber": "${registrationNumber!.year.toString().padLeft(4, '0')}-${registrationNumber!.month.toString().padLeft(2, '0')}-${registrationNumber!.day.toString().padLeft(2, '0')}",
    "registrationDate": "${registrationDate!.year.toString().padLeft(4, '0')}-${registrationDate!.month.toString().padLeft(2, '0')}-${registrationDate!.day.toString().padLeft(2, '0')}",
    "registrationValidityDate": registrationValidityDate,
    "address1": address1,
    "address2": address2,
    "location": location,
    "geoLocation": geoLocation,
    "pincode": pincode,
    "geographyMSTId1": geographyMstId1,
    "geographyMST1": geographyMst1?.toJson(),
    "geographyMSTId2": geographyMstId2,
    "geographyMST2": geographyMst2?.toJson(),
    "geographyMSTId3": geographyMstId3,
    "geographyMST3": geographyMst3?.toJson(),
    "geographyMSTId4": geographyMstId4,
    "geographyMST4": geographyMst4?.toJson(),
    "geographyMSTId5": geographyMstId5,
    "geographyMST5": geographyMst5?.toJson(),
    "geographyMSTId6": geographyMstId6,
    "geographyMST6": geographyMst6?.toJson(),
    "geographyMSTId7": geographyMstId7,
    "geographyMST7": geographyMst7,
    "geographyMSTId8": geographyMstId8,
    "geographyMST8": geographyMst8,
    "polygon": polygon,
    "extraHours": extraHours,
    "purchasePriceListMSTId": purchasePriceListMstId,
    "salesPriceListMSTId": salesPriceListMstId,
    "transferPriceListMSTId": transferPriceListMstId,
    "salesTaxCodeMSTId": salesTaxCodeMstId,
    "taxMessage": taxMessage,
    "termCondition": termCondition,
    "legalInformation": legalInformation,
    "thanksNotes": thanksNotes,
    "customerCare": customerCare,
    "abnNumber": abnNumber,
    "driverFloatAmount": driverFloatAmount,
    "dayStartFloatAmount": dayStartFloatAmount,
    "surchargeDTLList": surchargeDtlList == null ? [] : List<dynamic>.from(surchargeDtlList!.map((x) => x.toJson())),
    "documentStagesList": documentStagesList == null ? [] : List<dynamic>.from(documentStagesList!.map((x) => x.toJson())),
    "active": active,
  };
}

class DocumentStagesList {
  DateTime? createdOn;
  DateTime? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  int? outletDocumentStagesId;
  int? outletMstId;
  int? documentStagesId;
  String? standardTime;
  bool? present;
  bool? active;

  DocumentStagesList({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.outletDocumentStagesId,
    this.outletMstId,
    this.documentStagesId,
    this.standardTime,
    this.present,
    this.active,
  });

  factory DocumentStagesList.fromRawJson(String str) => DocumentStagesList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentStagesList.fromJson(Map<String, dynamic> json) => DocumentStagesList(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    outletDocumentStagesId: json["outletDocumentStagesId"],
    outletMstId: json["outletMSTId"],
    documentStagesId: json["documentStagesId"],
    standardTime: json["standardTime"],
    present: json["present"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "outletDocumentStagesId": outletDocumentStagesId,
    "outletMSTId": outletMstId,
    "documentStagesId": documentStagesId,
    "standardTime": standardTime,
    "present": present,
    "active": active,
  };
}

class GeographyMst1 {
  DateTime? createdOn;
  DateTime? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  int? geographyMstId;
  int? geographyTypeId;
  GeographyTypeMst? geographyTypeMst;
  String? geographyCode;
  String? geographyName;
  String? sortOrder;
  int? parentGeographyMstId;
  GeographyMst1? parentGeographyMst;
  bool? active;

  GeographyMst1({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.geographyMstId,
    this.geographyTypeId,
    this.geographyTypeMst,
    this.geographyCode,
    this.geographyName,
    this.sortOrder,
    this.parentGeographyMstId,
    this.parentGeographyMst,
    this.active,
  });

  factory GeographyMst1.fromRawJson(String str) => GeographyMst1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeographyMst1.fromJson(Map<String, dynamic> json) => GeographyMst1(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    geographyMstId: json["geographyMSTId"],
    geographyTypeId: json["geographyTypeId"],
    geographyTypeMst: json["geographyTypeMST"] == null ? null : GeographyTypeMst.fromJson(json["geographyTypeMST"]),
    geographyCode: json["geographyCode"],
    geographyName: json["geographyName"],
    sortOrder: json["sortOrder"],
    parentGeographyMstId: json["parentGeographyMSTId"],
    parentGeographyMst: json["parentGeographyMST"] == null ? null : GeographyMst1.fromJson(json["parentGeographyMST"]),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "geographyMSTId": geographyMstId,
    "geographyTypeId": geographyTypeId,
    "geographyTypeMST": geographyTypeMst?.toJson(),
    "geographyCode": geographyCode,
    "geographyName": geographyName,
    "sortOrder": sortOrder,
    "parentGeographyMSTId": parentGeographyMstId,
    "parentGeographyMST": parentGeographyMst?.toJson(),
    "active": active,
  };
}

class GeographyTypeMst {
  DateTime? createdOn;
  DateTime? modifiedOn;
  EdBy? createdBy;
  EdBy? modifiedBy;
  int? geographyTypeMstId;
  String? geographyTypeCode;
  String? geographyTypeName;
  int? parentGeographyId;
  dynamic parentGeographyName;
  String? sortOrder;
  bool? systemData;
  bool? active;

  GeographyTypeMst({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.geographyTypeMstId,
    this.geographyTypeCode,
    this.geographyTypeName,
    this.parentGeographyId,
    this.parentGeographyName,
    this.sortOrder,
    this.systemData,
    this.active,
  });

  factory GeographyTypeMst.fromRawJson(String str) => GeographyTypeMst.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeographyTypeMst.fromJson(Map<String, dynamic> json) => GeographyTypeMst(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: edByValues.map[json["createdBy"]]!,
    modifiedBy: edByValues.map[json["modifiedBy"]]!,
    geographyTypeMstId: json["geographyTypeMSTId"],
    geographyTypeCode: json["geographyTypeCode"],
    geographyTypeName: json["geographyTypeName"],
    parentGeographyId: json["parentGeographyId"],
    parentGeographyName: json["parentGeographyName"],
    sortOrder: json["sortOrder"],
    systemData: json["systemData"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": edByValues.reverse[createdBy],
    "modifiedBy": edByValues.reverse[modifiedBy],
    "geographyTypeMSTId": geographyTypeMstId,
    "geographyTypeCode": geographyTypeCode,
    "geographyTypeName": geographyTypeName,
    "parentGeographyId": parentGeographyId,
    "parentGeographyName": parentGeographyName,
    "sortOrder": sortOrder,
    "systemData": systemData,
    "active": active,
  };
}

enum EdBy {
  ADMIN,
  EMPTY
}

final edByValues = EnumValues({
  "admin": EdBy.ADMIN,
  "": EdBy.EMPTY
});

class SurchargeDtlList {
  DateTime? createdOn;
  DateTime? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  String? surchargeDtlId;
  String? surchargeName;
  bool? halfNHalf;
  int? outletMstId;
  dynamic toDate;
  dynamic fromDate;
  dynamic day;
  dynamic fromTime;
  dynamic toTime;
  int? amount;
  String? amountUnit;
  bool? active;

  SurchargeDtlList({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.surchargeDtlId,
    this.surchargeName,
    this.halfNHalf,
    this.outletMstId,
    this.toDate,
    this.fromDate,
    this.day,
    this.fromTime,
    this.toTime,
    this.amount,
    this.amountUnit,
    this.active,
  });

  factory SurchargeDtlList.fromRawJson(String str) => SurchargeDtlList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SurchargeDtlList.fromJson(Map<String, dynamic> json) => SurchargeDtlList(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    surchargeDtlId: json["surchargeDTLId"],
    surchargeName: json["surchargeName"],
    halfNHalf: json["halfNHalf"],
    outletMstId: json["outletMSTId"],
    toDate: json["toDate"],
    fromDate: json["fromDate"],
    day: json["day"],
    fromTime: json["fromTime"],
    toTime: json["toTime"],
    amount: json["amount"],
    amountUnit: json["amountUnit"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "surchargeDTLId": surchargeDtlId,
    "surchargeName": surchargeName,
    "halfNHalf": halfNHalf,
    "outletMSTId": outletMstId,
    "toDate": toDate,
    "fromDate": fromDate,
    "day": day,
    "fromTime": fromTime,
    "toTime": toTime,
    "amount": amount,
    "amountUnit": amountUnit,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
