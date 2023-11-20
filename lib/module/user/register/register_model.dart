import 'dart:convert';


class RegisterModel  {
  String? message;
  bool? status;
  Data? data;

  RegisterModel({
    this.message,
    this.status,
    this.data,
  });

  factory RegisterModel.fromRawJson(String str) => RegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
  Login? login;
  Customer? customer;

  Data({
    this.login,
    this.customer,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    login: json["login"] == null ? null : Login.fromJson(json["login"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "login": login?.toJson(),
    "customer": customer?.toJson(),
  };
}

class Customer {
  DateTime? createdOn;
  DateTime? modifiedOn;
  dynamic createdBy;
  dynamic modifiedBy;
  String? customerMstId;
  String? customerCode;
  String? customerFirstName;
  String? customerLastName;
  int? customerGroupMstId;
  CustomerGroupMst? customerGroupMst;
  dynamic gender;
  dynamic birthDate;
  dynamic anniversary;
  String? primaryEmail;
  String? primaryContact;
  bool? emailSubscription;
  bool? smsSubscription;
  dynamic ledgerBalance;
  dynamic customerAddressDtlList;
  dynamic storeInstruction;
  int? userMstId;
  UserMst? userMst;
  bool? aggregator;
  bool? active;

  Customer({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.customerMstId,
    this.customerCode,
    this.customerFirstName,
    this.customerLastName,
    this.customerGroupMstId,
    this.customerGroupMst,
    this.gender,
    this.birthDate,
    this.anniversary,
    this.primaryEmail,
    this.primaryContact,
    this.emailSubscription,
    this.smsSubscription,
    this.ledgerBalance,
    this.customerAddressDtlList,
    this.storeInstruction,
    this.userMstId,
    this.userMst,
    this.aggregator,
    this.active,
  });

  factory Customer.fromRawJson(String str) => Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    customerMstId: json["customerMSTId"],
    customerCode: json["customerCode"],
    customerFirstName: json["customerFirstName"],
    customerLastName: json["customerLastName"],
    customerGroupMstId: json["customerGroupMSTId"],
    customerGroupMst: json["customerGroupMST"] == null ? null : CustomerGroupMst.fromJson(json["customerGroupMST"]),
    gender: json["gender"],
    birthDate: json["birthDate"],
    anniversary: json["anniversary"],
    primaryEmail: json["primaryEmail"],
    primaryContact: json["primaryContact"],
    emailSubscription: json["emailSubscription"],
    smsSubscription: json["smsSubscription"],
    ledgerBalance: json["ledgerBalance"],
    customerAddressDtlList: json["customerAddressDTLList"],
    storeInstruction: json["storeInstruction"],
    userMstId: json["userMSTId"],
    userMst: json["userMST"] == null ? null : UserMst.fromJson(json["userMST"]),
    aggregator: json["aggregator"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "customerMSTId": customerMstId,
    "customerCode": customerCode,
    "customerFirstName": customerFirstName,
    "customerLastName": customerLastName,
    "customerGroupMSTId": customerGroupMstId,
    "customerGroupMST": customerGroupMst?.toJson(),
    "gender": gender,
    "birthDate": birthDate,
    "anniversary": anniversary,
    "primaryEmail": primaryEmail,
    "primaryContact": primaryContact,
    "emailSubscription": emailSubscription,
    "smsSubscription": smsSubscription,
    "ledgerBalance": ledgerBalance,
    "customerAddressDTLList": customerAddressDtlList,
    "storeInstruction": storeInstruction,
    "userMSTId": userMstId,
    "userMST": userMst?.toJson(),
    "aggregator": aggregator,
    "active": active,
  };
}

class CustomerGroupMst {
  DateTime? createdOn;
  DateTime? modifiedOn;
  dynamic createdBy;
  dynamic modifiedBy;
  int? customerGroupMstId;
  String? customerGroupCode;
  String? customerGroupName;
  dynamic sortOrder;
  bool? active;

  CustomerGroupMst({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.customerGroupMstId,
    this.customerGroupCode,
    this.customerGroupName,
    this.sortOrder,
    this.active,
  });

  factory CustomerGroupMst.fromRawJson(String str) => CustomerGroupMst.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerGroupMst.fromJson(Map<String, dynamic> json) => CustomerGroupMst(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    customerGroupMstId: json["customerGroupMSTId"],
    customerGroupCode: json["customerGroupCode"],
    customerGroupName: json["customerGroupName"],
    sortOrder: json["sortOrder"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "customerGroupMSTId": customerGroupMstId,
    "customerGroupCode": customerGroupCode,
    "customerGroupName": customerGroupName,
    "sortOrder": sortOrder,
    "active": active,
  };
}

class UserMst {
  DateTime? createdOn;
  DateTime? modifiedOn;
  dynamic createdBy;
  dynamic modifiedBy;
  int? userMstId;
  String? userCode;
  String? userName;
  dynamic userExternalCode;
  int? userGroupMstId;
  UserGroupMMst? userGroupMst;
  int? userRoleMstId;
  UserRoleMst? userRoleMst;
  int? userGroupManagerMstId;
  UserGroupMMst? userGroupManagerMst;
  dynamic gender;
  String? primaryContactNumber;
  dynamic secondaryContactNumber;
  String? primaryEmailId;
  dynamic secondaryEmailId;
  dynamic profileImage;
  String? password;
  dynamic invoiceDiscountLimit;
  dynamic dueBalance;
  dynamic ipAddress;
  dynamic forgotPasswordOtp;
  dynamic forgotPasswordOtpExpiry;
  dynamic userOutletAccessDtlList;
  dynamic userAddressMstList;
  dynamic lock;
  bool? ipUser;
  dynamic deliveryPerson;
  bool? signUp;
  bool? active;

  UserMst({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.userMstId,
    this.userCode,
    this.userName,
    this.userExternalCode,
    this.userGroupMstId,
    this.userGroupMst,
    this.userRoleMstId,
    this.userRoleMst,
    this.userGroupManagerMstId,
    this.userGroupManagerMst,
    this.gender,
    this.primaryContactNumber,
    this.secondaryContactNumber,
    this.primaryEmailId,
    this.secondaryEmailId,
    this.profileImage,
    this.password,
    this.invoiceDiscountLimit,
    this.dueBalance,
    this.ipAddress,
    this.forgotPasswordOtp,
    this.forgotPasswordOtpExpiry,
    this.userOutletAccessDtlList,
    this.userAddressMstList,
    this.lock,
    this.ipUser,
    this.deliveryPerson,
    this.signUp,
    this.active,
  });

  factory UserMst.fromRawJson(String str) => UserMst.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserMst.fromJson(Map<String, dynamic> json) => UserMst(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    userMstId: json["userMSTId"],
    userCode: json["userCode"],
    userName: json["userName"],
    userExternalCode: json["userExternalCode"],
    userGroupMstId: json["userGroupMSTId"],
    userGroupMst: json["userGroupMST"] == null ? null : UserGroupMMst.fromJson(json["userGroupMST"]),
    userRoleMstId: json["userRoleMSTId"],
    userRoleMst: json["userRoleMST"] == null ? null : UserRoleMst.fromJson(json["userRoleMST"]),
    userGroupManagerMstId: json["userGroupManagerMSTId"],
    userGroupManagerMst: json["userGroupManagerMST"] == null ? null : UserGroupMMst.fromJson(json["userGroupManagerMST"]),
    gender: json["gender"],
    primaryContactNumber: json["primaryContactNumber"],
    secondaryContactNumber: json["secondaryContactNumber"],
    primaryEmailId: json["primaryEmailId"],
    secondaryEmailId: json["secondaryEmailId"],
    profileImage: json["profileImage"],
    password: json["password"],
    invoiceDiscountLimit: json["invoiceDiscountLimit"],
    dueBalance: json["dueBalance"],
    ipAddress: json["ipAddress"],
    forgotPasswordOtp: json["forgotPasswordOTP"],
    forgotPasswordOtpExpiry: json["forgotPasswordOTPExpiry"],
    userOutletAccessDtlList: json["userOutletAccessDTLList"],
    userAddressMstList: json["userAddressMSTList"],
    lock: json["lock"],
    ipUser: json["ipUser"],
    deliveryPerson: json["deliveryPerson"],
    signUp: json["signUp"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "userMSTId": userMstId,
    "userCode": userCode,
    "userName": userName,
    "userExternalCode": userExternalCode,
    "userGroupMSTId": userGroupMstId,
    "userGroupMST": userGroupMst?.toJson(),
    "userRoleMSTId": userRoleMstId,
    "userRoleMST": userRoleMst?.toJson(),
    "userGroupManagerMSTId": userGroupManagerMstId,
    "userGroupManagerMST": userGroupManagerMst?.toJson(),
    "gender": gender,
    "primaryContactNumber": primaryContactNumber,
    "secondaryContactNumber": secondaryContactNumber,
    "primaryEmailId": primaryEmailId,
    "secondaryEmailId": secondaryEmailId,
    "profileImage": profileImage,
    "password": password,
    "invoiceDiscountLimit": invoiceDiscountLimit,
    "dueBalance": dueBalance,
    "ipAddress": ipAddress,
    "forgotPasswordOTP": forgotPasswordOtp,
    "forgotPasswordOTPExpiry": forgotPasswordOtpExpiry,
    "userOutletAccessDTLList": userOutletAccessDtlList,
    "userAddressMSTList": userAddressMstList,
    "lock": lock,
    "ipUser": ipUser,
    "deliveryPerson": deliveryPerson,
    "signUp": signUp,
    "active": active,
  };
}

class UserGroupMMst {
  DateTime? createdOn;
  DateTime? modifiedOn;
  dynamic createdBy;
  dynamic modifiedBy;
  int? userGroupMstId;
  String? groupCode;
  String? groupName;
  dynamic sortOrder;
  bool? systemData;
  bool? active;

  UserGroupMMst({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.userGroupMstId,
    this.groupCode,
    this.groupName,
    this.sortOrder,
    this.systemData,
    this.active,
  });

  factory UserGroupMMst.fromRawJson(String str) => UserGroupMMst.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserGroupMMst.fromJson(Map<String, dynamic> json) => UserGroupMMst(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    userGroupMstId: json["userGroupMSTId"],
    groupCode: json["groupCode"],
    groupName: json["groupName"],
    sortOrder: json["sortOrder"],
    systemData: json["systemData"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "userGroupMSTId": userGroupMstId,
    "groupCode": groupCode,
    "groupName": groupName,
    "sortOrder": sortOrder,
    "systemData": systemData,
    "active": active,
  };
}

class UserRoleMst {
  DateTime? createdOn;
  DateTime? modifiedOn;
  dynamic createdBy;
  dynamic modifiedBy;
  int? userRoleMstId;
  String? roleCode;
  String? roleName;
  int? sortOrder;
  bool? systemData;
  bool? active;

  UserRoleMst({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.userRoleMstId,
    this.roleCode,
    this.roleName,
    this.sortOrder,
    this.systemData,
    this.active,
  });

  factory UserRoleMst.fromRawJson(String str) => UserRoleMst.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRoleMst.fromJson(Map<String, dynamic> json) => UserRoleMst(
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    modifiedOn: json["modifiedOn"] == null ? null : DateTime.parse(json["modifiedOn"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    userRoleMstId: json["userRoleMSTId"],
    roleCode: json["roleCode"],
    roleName: json["roleName"],
    sortOrder: json["sortOrder"],
    systemData: json["systemData"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn?.toIso8601String(),
    "modifiedOn": modifiedOn?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "userRoleMSTId": userRoleMstId,
    "roleCode": roleCode,
    "roleName": roleName,
    "sortOrder": sortOrder,
    "systemData": systemData,
    "active": active,
  };
}

class Login {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? jwtToken;
  UserMst? userMst;

  Login({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.emailId,
    this.mobileNumber,
    this.jwtToken,
    this.userMst,
  });

  factory Login.fromRawJson(String str) => Login.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    id: json["id"],
    userName: json["userName"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    emailId: json["emailId"],
    mobileNumber: json["mobileNumber"],
    jwtToken: json["jwtToken"],
    userMst: json["userMST"] == null ? null : UserMst.fromJson(json["userMST"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "firstName": firstName,
    "lastName": lastName,
    "emailId": emailId,
    "mobileNumber": mobileNumber,
    "jwtToken": jwtToken,
    "userMST": userMst?.toJson(),
  };
}
