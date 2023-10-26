// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? jwtToken;
  UserMst? userMst;

  LoginModel({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.emailId,
    this.mobileNumber,
    this.jwtToken,
    this.userMst,
  });

  LoginModel copyWith({
    String? id,
    String? userName,
    String? firstName,
    String? lastName,
    String? emailId,
    String? mobileNumber,
    String? jwtToken,
    UserMst? userMst,
  }) =>
      LoginModel(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        emailId: emailId ?? this.emailId,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        jwtToken: jwtToken ?? this.jwtToken,
        userMst: userMst ?? this.userMst,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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

class UserMst {
  DateTime? createdOn;
  DateTime? modifiedOn;
  dynamic createdBy;
  dynamic modifiedBy;
  String? userMstId;
  String? userCode;
  String? userName;
  dynamic userExternalCode;
  String? userGroupMstId;
  UserGroupMMst? userGroupMst;
  String? userRoleMstId;
  UserRoleMst? userRoleMst;
  String? userGroupManagerMstId;
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
  List<dynamic>? userOutletAccessDtlList;
  List<dynamic>? userAddressMstList;
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

  UserMst copyWith({
    DateTime? createdOn,
    DateTime? modifiedOn,
    dynamic createdBy,
    dynamic modifiedBy,
    String? userMstId,
    String? userCode,
    String? userName,
    dynamic userExternalCode,
    String? userGroupMstId,
    UserGroupMMst? userGroupMst,
    String? userRoleMstId,
    UserRoleMst? userRoleMst,
    String? userGroupManagerMstId,
    UserGroupMMst? userGroupManagerMst,
    dynamic gender,
    String? primaryContactNumber,
    dynamic secondaryContactNumber,
    String? primaryEmailId,
    dynamic secondaryEmailId,
    dynamic profileImage,
    String? password,
    dynamic invoiceDiscountLimit,
    dynamic dueBalance,
    dynamic ipAddress,
    dynamic forgotPasswordOtp,
    dynamic forgotPasswordOtpExpiry,
    List<dynamic>? userOutletAccessDtlList,
    List<dynamic>? userAddressMstList,
    dynamic lock,
    bool? ipUser,
    dynamic deliveryPerson,
    bool? signUp,
    bool? active,
  }) =>
      UserMst(
        createdOn: createdOn ?? this.createdOn,
        modifiedOn: modifiedOn ?? this.modifiedOn,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        userMstId: userMstId ?? this.userMstId,
        userCode: userCode ?? this.userCode,
        userName: userName ?? this.userName,
        userExternalCode: userExternalCode ?? this.userExternalCode,
        userGroupMstId: userGroupMstId ?? this.userGroupMstId,
        userGroupMst: userGroupMst ?? this.userGroupMst,
        userRoleMstId: userRoleMstId ?? this.userRoleMstId,
        userRoleMst: userRoleMst ?? this.userRoleMst,
        userGroupManagerMstId: userGroupManagerMstId ?? this.userGroupManagerMstId,
        userGroupManagerMst: userGroupManagerMst ?? this.userGroupManagerMst,
        gender: gender ?? this.gender,
        primaryContactNumber: primaryContactNumber ?? this.primaryContactNumber,
        secondaryContactNumber: secondaryContactNumber ?? this.secondaryContactNumber,
        primaryEmailId: primaryEmailId ?? this.primaryEmailId,
        secondaryEmailId: secondaryEmailId ?? this.secondaryEmailId,
        profileImage: profileImage ?? this.profileImage,
        password: password ?? this.password,
        invoiceDiscountLimit: invoiceDiscountLimit ?? this.invoiceDiscountLimit,
        dueBalance: dueBalance ?? this.dueBalance,
        ipAddress: ipAddress ?? this.ipAddress,
        forgotPasswordOtp: forgotPasswordOtp ?? this.forgotPasswordOtp,
        forgotPasswordOtpExpiry: forgotPasswordOtpExpiry ?? this.forgotPasswordOtpExpiry,
        userOutletAccessDtlList: userOutletAccessDtlList ?? this.userOutletAccessDtlList,
        userAddressMstList: userAddressMstList ?? this.userAddressMstList,
        lock: lock ?? this.lock,
        ipUser: ipUser ?? this.ipUser,
        deliveryPerson: deliveryPerson ?? this.deliveryPerson,
        signUp: signUp ?? this.signUp,
        active: active ?? this.active,
      );

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
    userOutletAccessDtlList: json["userOutletAccessDTLList"] == null ? [] : List<dynamic>.from(json["userOutletAccessDTLList"]!.map((x) => x)),
    userAddressMstList: json["userAddressMSTList"] == null ? [] : List<dynamic>.from(json["userAddressMSTList"]!.map((x) => x)),
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
    "userOutletAccessDTLList": userOutletAccessDtlList == null ? [] : List<dynamic>.from(userOutletAccessDtlList!.map((x) => x)),
    "userAddressMSTList": userAddressMstList == null ? [] : List<dynamic>.from(userAddressMstList!.map((x) => x)),
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
  String? userGroupMstId;
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

  UserGroupMMst copyWith({
    DateTime? createdOn,
    DateTime? modifiedOn,
    dynamic createdBy,
    dynamic modifiedBy,
    String? userGroupMstId,
    String? groupCode,
    String? groupName,
    dynamic sortOrder,
    bool? systemData,
    bool? active,
  }) =>
      UserGroupMMst(
        createdOn: createdOn ?? this.createdOn,
        modifiedOn: modifiedOn ?? this.modifiedOn,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        userGroupMstId: userGroupMstId ?? this.userGroupMstId,
        groupCode: groupCode ?? this.groupCode,
        groupName: groupName ?? this.groupName,
        sortOrder: sortOrder ?? this.sortOrder,
        systemData: systemData ?? this.systemData,
        active: active ?? this.active,
      );

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
  String? userRoleMstId;
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

  UserRoleMst copyWith({
    DateTime? createdOn,
    DateTime? modifiedOn,
    dynamic createdBy,
    dynamic modifiedBy,
    String? userRoleMstId,
    String? roleCode,
    String? roleName,
    int? sortOrder,
    bool? systemData,
    bool? active,
  }) =>
      UserRoleMst(
        createdOn: createdOn ?? this.createdOn,
        modifiedOn: modifiedOn ?? this.modifiedOn,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        userRoleMstId: userRoleMstId ?? this.userRoleMstId,
        roleCode: roleCode ?? this.roleCode,
        roleName: roleName ?? this.roleName,
        sortOrder: sortOrder ?? this.sortOrder,
        systemData: systemData ?? this.systemData,
        active: active ?? this.active,
      );

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
