class AllActiveOutletGeographyModel {
  String? message;
  bool? status;
  List<GeographyData?>? data;

  AllActiveOutletGeographyModel({
    this.message,
    this.status,
    this.data,
  });

  factory AllActiveOutletGeographyModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List<dynamic>?;
    List<GeographyData?>? data = dataList?.map((dynamic item) => GeographyData.fromJson(item)).toList();

    return AllActiveOutletGeographyModel(
      message: json['message'],
      status: json['status'],
      data: data,
    );
  }
}

class GeographyData {
  int? geographyMSTId;
  String? geographyTypeCode;
  String? geographyTypeName;
  String? geographyCode;
  String? geographyName;
  int? parentGeographyMSTId;
  ParentGeographyMST? parentGeographyMST;

  GeographyData({
    this.geographyMSTId,
    this.geographyTypeCode,
    this.geographyTypeName,
    this.geographyCode,
    this.geographyName,
    this.parentGeographyMSTId,
    this.parentGeographyMST,
  });

  factory GeographyData.fromJson(Map<String, dynamic> json) {
    return GeographyData(
      geographyMSTId: json['geographyMSTId'],
      geographyTypeCode: json['geographyTypeCode'],
      geographyTypeName: json['geographyTypeName'],
      geographyCode: json['geographyCode'],
      geographyName: json['geographyName'],
      parentGeographyMSTId: json['parentGeographyMSTId'],
      parentGeographyMST: json['parentGeographyMST'] != null ? ParentGeographyMST.fromJson(json['parentGeographyMST']) : null,
    );
  }
}

class ParentGeographyMST {
  int? geographyMSTId;
  String? geographyCode;
  String? geographyName;

  ParentGeographyMST({
    this.geographyMSTId,
    this.geographyCode,
    this.geographyName,
  });

  factory ParentGeographyMST.fromJson(Map<String, dynamic> json) {
    return ParentGeographyMST(
      geographyMSTId: json['geographyMSTId'],
      geographyCode: json['geographyCode'],
      geographyName: json['geographyName'],
    );
  }
}












