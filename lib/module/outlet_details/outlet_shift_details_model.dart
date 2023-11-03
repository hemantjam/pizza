class OutletShiftDetailsModel {
  String? message;
  bool? status;
  ShiftData? data;

  OutletShiftDetailsModel({
    this.message,
    this.status,
    this.data,
  });

  factory OutletShiftDetailsModel.fromJson(Map<String, dynamic> json) {
    return OutletShiftDetailsModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null ? ShiftData.fromJson(json['data']) : null,
    );
  }
}

class ShiftData {
  List<ShiftItem?>? special;
  List<ShiftItem?>? regular;

  ShiftData({
    this.special,
    this.regular,
  });

  factory ShiftData.fromJson(Map<String, dynamic> json) {
    var specialList = json['special'] as List<dynamic>?;
    var regularList = json['regular'] as List<dynamic>?;

    List<ShiftItem?>? special = specialList?.map((item) => ShiftItem.fromJson(item)).toList();
    List<ShiftItem?>? regular = regularList?.map((item) => ShiftItem.fromJson(item)).toList();

    return ShiftData(
      special: special,
      regular: regular,
    );
  }
}

class ShiftItem {
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

  ShiftItem({
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

  factory ShiftItem.fromJson(Map<String, dynamic> json) {
    return ShiftItem(
      shiftId: json['shiftId'],
      day: json['day'],
      date: json['date'].toString(),
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
}
