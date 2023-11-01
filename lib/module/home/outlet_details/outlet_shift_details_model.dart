class ShiftByOutletModel {
  final String? message;
  final bool? status;
  final Map<String, ShiftData?>? data;

  ShiftByOutletModel({this.message, this.status, this.data});

  factory ShiftByOutletModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? dataJson = json['data'];
    Map<String, ShiftData?>? shiftData = {};

    dataJson?.forEach((key, value) {
      shiftData[key] = ShiftData.fromJson(value);
    });

    return ShiftByOutletModel(
      message: json['message'],
      status: json['status'],
      data: shiftData,
    );
  }
}

class ShiftData {
  final List<RegularShift>? special;
  final List<RegularShift?>? regular;

  ShiftData({this.special, this.regular});

  factory ShiftData.fromJson(Map<String, dynamic> json) {
    List<RegularShift>? specialList = [];
    List<RegularShift?>? regularList = [];

    if (json['regular'] != null) {
      for (var item in json['regular']) {
        regularList.add(RegularShift.fromJson(item));
      }
    }
    if (json['special'] != null) {
      for (var item in json['special']) {
        regularList.add(RegularShift.fromJson(item));
      }
    }
    return ShiftData(
      special: specialList,
      regular: regularList,
    );
  }
}

class RegularShift {
  final int? outletShiftDTLId;
  final int? operationalConfigMSTId;
  final String? orderType;
  final String? leadTime;
  final int? day;
  final String? startTime;
  final String? endTime;
  final String? cutoffTime;
  final String? intervalTime;

  RegularShift({
    this.outletShiftDTLId,
    this.operationalConfigMSTId,
    this.orderType,
    this.leadTime,
    this.day,
    this.startTime,
    this.endTime,
    this.cutoffTime,
    this.intervalTime,
  });

  factory RegularShift.fromJson(Map<String, dynamic> json) {
    return RegularShift(
      outletShiftDTLId: json['outletShiftDTLId'],
      operationalConfigMSTId: json['operationalConfigMSTId'],
      orderType: json['orderType'],
      leadTime: json['leadTime'],
      day: json['day'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      cutoffTime: json['cutoffTime'],
      intervalTime: json['intervalTime'],
    );
  }
}
