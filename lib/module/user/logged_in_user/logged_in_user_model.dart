import 'package:get/get.dart';

import '../login/login_model.dart';

class LoggedInUserModel {
  String? message;
  bool? status;
  Data? data;

  LoggedInUserModel({this.message, this.status, this.data});

  factory LoggedInUserModel.fromJson(Map<String, dynamic> json) {
    return LoggedInUserModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  CustomerMST? customerMST;
  UserMST? userMST;

  Data({this.customerMST, this.userMST});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      customerMST: json['customerMST'] != null
          ? CustomerMST.fromJson(json['customerMST'])
          : null,
      userMST:
          json['userMST'] != null ? UserMST.fromJson(json['userMST']) : null,
    );
  }
}

class CustomerMST {
  String? customerMSTId;
  String? customerCode;
  String? customerFirstName;
  String? customerLastName;
  int? customerGroupMSTId;
  CustomerGroupMST? customerGroupMST;
  String? gender;
  String? birthDate;
  String? anniversary;
  String? primaryEmail;
  String? primaryContact;
  bool? emailSubscription;
  bool? smsSubscription;
  String? ledgerBalance;
  List<dynamic>? customerAddressDTLList;
  String? storeInstruction;
  int? userMSTId;
  UserMST? userMST;
  bool? aggregator;

  CustomerMST({
    this.customerMSTId,
    this.customerCode,
    this.customerFirstName,
    this.customerLastName,
    this.customerGroupMSTId,
    this.customerGroupMST,
    this.gender,
    this.birthDate,
    this.anniversary,
    this.primaryEmail,
    this.primaryContact,
    this.emailSubscription,
    this.smsSubscription,
    this.ledgerBalance,
    this.customerAddressDTLList,
    this.storeInstruction,
    this.userMSTId,
    this.userMST,
    this.aggregator,
  });

  factory CustomerMST.fromJson(Map<String, dynamic> json) {
    return CustomerMST(
      customerMSTId: json['customerMSTId'],
      customerCode: json['customerCode'],
      customerFirstName: json['customerFirstName'],
      customerLastName: json['customerLastName'],
      customerGroupMSTId: json['customerGroupMSTId'],
      customerGroupMST: json['customerGroupMST'] != null
          ? CustomerGroupMST.fromJson(json['customerGroupMST'])
          : null,
      gender: json['gender'],
      birthDate: json['birthDate'],
      anniversary: json['anniversary'],
      primaryEmail: json['primaryEmail'],
      primaryContact: json['primaryContact'],
      emailSubscription: json['emailSubscription'],
      smsSubscription: json['smsSubscription'],
      ledgerBalance: json['ledgerBalance'],
      customerAddressDTLList: json['customerAddressDTLList'],
      storeInstruction: json['storeInstruction'],
      userMSTId: json['userMSTId'],
      userMST:
          json['userMST'] != null ? UserMST.fromJson(json['userMST']) : null,
      aggregator: json['aggregator'],
    );
  }
}

class CustomerGroupMST {
  int? customerGroupMSTId;
  String? customerGroupCode;
  String? customerGroupName;
  String? sortOrder;

  CustomerGroupMST({
    this.customerGroupMSTId,
    this.customerGroupCode,
    this.customerGroupName,
    this.sortOrder,
  });

  factory CustomerGroupMST.fromJson(Map<String, dynamic> json) {
    return CustomerGroupMST(
      customerGroupMSTId: json['customerGroupMSTId'],
      customerGroupCode: json['customerGroupCode'],
      customerGroupName: json['customerGroupName'],
      sortOrder: json['sortOrder'],
    );
  }
}
