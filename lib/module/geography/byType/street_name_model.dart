import 'dart:convert';

class GeographyByTypeModel {
  String? message;
  bool? status;
  List<SingleGeographyModel>? data;

  GeographyByTypeModel({
    this.message,
    this.status,
    this.data,
  });

  factory GeographyByTypeModel.fromRawJson(String str) =>
      GeographyByTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeographyByTypeModel.fromJson(Map<String, dynamic> json) =>
      GeographyByTypeModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<SingleGeographyModel>.from(
                json["data"]!.map((x) => SingleGeographyModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SingleGeographyModel {
  bool? active;
  String? createdBy;
  DateTime? createdOn;
  String? geographyCode;
  int? geographyMstId;
  String? geographyName;
  int? geographyTypeId;
  GeographyTypeMst? geographyTypeMst;
  String? modifiedBy;
  DateTime? modifiedOn;
  SingleGeographyModel? parentGeographyMst;
  int? parentGeographyMstId;
  String? sortOrder;

  SingleGeographyModel({
    this.active,
    this.createdBy,
    this.createdOn,
    this.geographyCode,
    this.geographyMstId,
    this.geographyName,
    this.geographyTypeId,
    this.geographyTypeMst,
    this.modifiedBy,
    this.modifiedOn,
    this.parentGeographyMst,
    this.parentGeographyMstId,
    this.sortOrder,
  });

  factory SingleGeographyModel.fromRawJson(String str) =>
      SingleGeographyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleGeographyModel.fromJson(Map<String, dynamic> json) =>
      SingleGeographyModel(
        active: json["active"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"] == null
            ? null
            : DateTime.parse(json["createdOn"]),
        geographyCode: json["geographyCode"],
        geographyMstId: json["geographyMSTId"],
        geographyName: json["geographyName"],
        geographyTypeId: json["geographyTypeId"],
        geographyTypeMst: json["geographyTypeMST"] == null
            ? null
            : GeographyTypeMst.fromJson(json["geographyTypeMST"]),
        modifiedBy: json["modifiedBy"],
        modifiedOn: json["modifiedOn"] == null
            ? null
            : DateTime.parse(json["modifiedOn"]),
        parentGeographyMst: json["parentGeographyMST"] == null
            ? null
            : SingleGeographyModel.fromJson(json["parentGeographyMST"]),
        parentGeographyMstId: json["parentGeographyMSTId"],
        sortOrder: json["sortOrder"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "createdBy": createdBy,
        "createdOn": createdOn?.toIso8601String(),
        "geographyCode": geographyCode,
        "geographyMSTId": geographyMstId,
        "geographyName": geographyName,
        "geographyTypeId": geographyTypeId,
        "geographyTypeMST": geographyTypeMst?.toJson(),
        "modifiedBy": modifiedBy,
        "modifiedOn": modifiedOn?.toIso8601String(),
        "parentGeographyMST": parentGeographyMst?.toJson(),
        "parentGeographyMSTId": parentGeographyMstId,
        "sortOrder": sortOrder,
      };
}

class GeographyTypeMst {
  bool? active;
  String? createdBy;
  DateTime? createdOn;
  String? geographyTypeCode;
  int? geographyTypeMstId;
  String? geographyTypeName;
  String? modifiedBy;
  DateTime? modifiedOn;
  int? parentGeographyId;
  String? parentGeographyName;
  String? sortOrder;
  bool? systemData;

  GeographyTypeMst({
    this.active,
    this.createdBy,
    this.createdOn,
    this.geographyTypeCode,
    this.geographyTypeMstId,
    this.geographyTypeName,
    this.modifiedBy,
    this.modifiedOn,
    this.parentGeographyId,
    this.parentGeographyName,
    this.sortOrder,
    this.systemData,
  });

  factory GeographyTypeMst.fromRawJson(String str) =>
      GeographyTypeMst.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeographyTypeMst.fromJson(Map<String, dynamic> json) =>
      GeographyTypeMst(
        active: json["active"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"] == null
            ? null
            : DateTime.parse(json["createdOn"]),
        geographyTypeCode: json["geographyTypeCode"],
        geographyTypeMstId: json["geographyTypeMSTId"],
        geographyTypeName: json["geographyTypeName"],
        modifiedBy: json["modifiedBy"],
        modifiedOn: json["modifiedOn"] == null
            ? null
            : DateTime.parse(json["modifiedOn"]),
        parentGeographyId: json["parentGeographyId"],
        parentGeographyName: json["parentGeographyName"],
        sortOrder: json["sortOrder"],
        systemData: json["systemData"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "createdBy": createdBy,
        "createdOn": createdOn?.toIso8601String(),
        "geographyTypeCode": geographyTypeCode,
        "geographyTypeMSTId": geographyTypeMstId,
        "geographyTypeName": geographyTypeName,
        "modifiedBy": modifiedBy,
        "modifiedOn": modifiedOn?.toIso8601String(),
        "parentGeographyId": parentGeographyId,
        "parentGeographyName": parentGeographyName,
        "sortOrder": sortOrder,
        "systemData": systemData,
      };
}
