import 'dart:convert';

class AllActiveOutletModel {
  String? message;
  bool? status;
  List<Datum>? data;

  AllActiveOutletModel({
    this.message,
    this.status,
    this.data,
  });

  factory AllActiveOutletModel.fromRawJson(String str) => AllActiveOutletModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllActiveOutletModel.fromJson(Map<String, dynamic> json) => AllActiveOutletModel(
    message: json["message"],
    status: json["status"],
    data: json["Data"] == null ? [] : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? geographyMstId;
  String? geographyTypeCode;
  String? geographyTypeName;
  String? geographyCode;
  String? geographyName;
  int? parentGeographyMstId;
  ParentGeographyMst? parentGeographyMst;

  Datum({
    this.geographyMstId,
    this.geographyTypeCode,
    this.geographyTypeName,
    this.geographyCode,
    this.geographyName,
    this.parentGeographyMstId,
    this.parentGeographyMst,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    geographyMstId: json["geographyMSTId"],
    geographyTypeCode: json["geographyTypeCode"],
    geographyTypeName: json["geographyTypeName"],
    geographyCode: json["geographyCode"],
    geographyName: json["geographyName"],
    parentGeographyMstId: json["parentGeographyMSTId"],
    parentGeographyMst: json["parentGeographyMST"] == null ? null : ParentGeographyMst.fromJson(json["parentGeographyMST"]),
  );

  Map<String, dynamic> toJson() => {
    "geographyMSTId": geographyMstId,
    "geographyTypeCode": geographyTypeCode,
    "geographyTypeName": geographyTypeName,
    "geographyCode": geographyCode,
    "geographyName": geographyName,
    "parentGeographyMSTId": parentGeographyMstId,
    "parentGeographyMST": parentGeographyMst?.toJson(),
  };
}

class ParentGeographyMst {
  int? geographyMstId;
  String? geographyCode;
  String? geographyName;

  ParentGeographyMst({
    this.geographyMstId,
    this.geographyCode,
    this.geographyName,
  });

  factory ParentGeographyMst.fromRawJson(String str) => ParentGeographyMst.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ParentGeographyMst.fromJson(Map<String, dynamic> json) => ParentGeographyMst(
    geographyMstId: json["geographyMSTId"],
    geographyCode: json["geographyCode"],
    geographyName: json["geographyName"],
  );

  Map<String, dynamic> toJson() => {
    "geographyMSTId": geographyMstId,
    "geographyCode": geographyCode,
    "geographyName": geographyName,
  };
}
