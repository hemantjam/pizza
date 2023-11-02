class OutletShiftDetailsModel {
  String? message;
  bool? status;
  Data? data;

  OutletShiftDetailsModel({this.message, this.status, this.data});

  factory OutletShiftDetailsModel.fromJson(Map<String, dynamic> json) {
    return OutletShiftDetailsModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class Data {
  List<ShiftData>? special;
  List<ShiftData>? regular;

  Data({this.special, this.regular});

  factory Data.fromJson(Map<String, dynamic> json) {
    final specialList = json['special'] as List;
    final regularList = json['regular'] as List;

    return Data(
      special: specialList.map((item) => ShiftData.fromJson(item)).toList(),
      regular: regularList.map((item) => ShiftData.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'special': special?.map((item) => item.toJson()).toList(),
      'regular': regular?.map((item) => item.toJson()).toList(),
    };
  }
}

class ShiftData {
  int? shiftId;
  int? day;
  String? date;
  String? leadTime;
  String? startTime;
  String? endTime;
  String? cutoffTime;
  String? intervalTime;
  String? orderTypeCode;
  String? orderTypeName;
  String? orderTypeId;
  bool? off;
  bool? special;

  ShiftData({
    this.shiftId,
    this.day,
    this.date,
    this.leadTime,
    this.startTime,
    this.endTime,
    this.cutoffTime,
    this.intervalTime,
    this.orderTypeCode,
    this.orderTypeName,
    this.orderTypeId,
    this.off,
    this.special,
  });

  factory ShiftData.fromJson(Map<String, dynamic> json) {
    return ShiftData(
      shiftId: json['shiftId'],
      day: json['day'],
      date: json['date'],
      leadTime: json['leadTime'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      cutoffTime: json['cutoffTime'],
      intervalTime: json['intervalTime'],
      orderTypeCode: json['orderTypeCode'],
      orderTypeName: json['orderTypeName'],
      orderTypeId: json['orderTypeId'],
      off: json['off'],
      special: json['special'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shiftId': shiftId,
      'day': day,
      'date': date,
      'leadTime': leadTime,
      'startTime': startTime,
      'endTime': endTime,
      'cutoffTime': cutoffTime,
      'intervalTime': intervalTime,
      'orderTypeCode': orderTypeCode,
      'orderTypeName': orderTypeName,
      'orderTypeId': orderTypeId,
      'off': off,
      'special': special,
    };
  }
}
