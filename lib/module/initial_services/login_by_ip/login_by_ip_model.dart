class LoginByIpModel {
  String? message;
  bool? status;
  Data? data;

  LoginByIpModel({this.message, this.status, this.data});

  factory LoginByIpModel.fromJson(Map<String, dynamic> json) {
    return LoginByIpModel(
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
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? jwtToken;
  UserMST? userMST;

  Data({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.emailId,
    this.mobileNumber,
    this.jwtToken,
    this.userMST,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      emailId: json['emailId'],
      mobileNumber: json['mobileNumber'],
      jwtToken: json['jwtToken'],
      userMST: json['userMST'] != null ? UserMST.fromJson(json['userMST']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'emailId': emailId,
      'mobileNumber': mobileNumber,
      'jwtToken': jwtToken,
      'userMST': userMST?.toJson(),
    };
  }
}

class UserMST {
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  String? userMSTId;
  String? userCode;
  String? userName;
  String? userExternalCode;
  String? userGroupMSTId;
  UserGroupMST? userGroupMST;
  String? userRoleMSTId;
  UserRoleMST? userRoleMST;
  String? userGroupManagerMSTId;
  UserGroupManagerMST? userGroupManagerMST;
  String? gender;
  String? primaryContactNumber;
  String? secondaryContactNumber;
  String? primaryEmailId;
  String? secondaryEmailId;
  String? profileImage;
  String? password;
  String? ipAddress;
  String? forgotPasswordOTP;
  String? forgotPasswordOTPExpiry;
  bool? ipUser;
  bool? deliveryPerson;
  bool? signUp;
  bool? active;

  UserMST({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.userMSTId,
    this.userCode,
    this.userName,
    this.userExternalCode,
    this.userGroupMSTId,
    this.userGroupMST,
    this.userRoleMSTId,
    this.userRoleMST,
    this.userGroupManagerMSTId,
    this.userGroupManagerMST,
    this.gender,
    this.primaryContactNumber,
    this.secondaryContactNumber,
    this.primaryEmailId,
    this.secondaryEmailId,
    this.profileImage,
    this.password,
    this.ipAddress,
    this.forgotPasswordOTP,
    this.forgotPasswordOTPExpiry,
    this.ipUser,
    this.deliveryPerson,
    this.signUp,
    this.active,
  });

  factory UserMST.fromJson(Map<String, dynamic> json) {
    return UserMST(
      createdOn: json['createdOn'],
      modifiedOn: json['modifiedOn'],
      createdBy: json['createdBy'],
      modifiedBy: json['modifiedBy'],
      userMSTId: json['userMSTId'],
      userCode: json['userCode'],
      userName: json['userName'],
      userExternalCode: json['userExternalCode'],
      userGroupMSTId: json['userGroupMSTId'],
      userGroupMST: json['userGroupMST'] != null ? UserGroupMST.fromJson(json['userGroupMST']) : null,
      userRoleMSTId: json['userRoleMSTId'],
      userRoleMST: json['userRoleMST'] != null ? UserRoleMST.fromJson(json['userRoleMST']) : null,
      userGroupManagerMSTId: json['userGroupManagerMSTId'],
      userGroupManagerMST: json['userGroupManagerMST'] != null
          ? UserGroupManagerMST.fromJson(json['userGroupManagerMST'])
          : null,
      gender: json['gender'],
      primaryContactNumber: json['primaryContactNumber'],
      secondaryContactNumber: json['secondaryContactNumber'],
      primaryEmailId: json['primaryEmailId'],
      secondaryEmailId: json['secondaryEmailId'],
      profileImage: json['profileImage'],
      password: json['password'],
      ipAddress: json['ipAddress'],
      forgotPasswordOTP: json['forgotPasswordOTP'],
      forgotPasswordOTPExpiry: json['forgotPasswordOTPExpiry'],
      ipUser: json['ipUser'],
      deliveryPerson: json['deliveryPerson'],
      signUp: json['signUp'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdOn': createdOn,
      'modifiedOn': modifiedOn,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'userMSTId': userMSTId,
      'userCode': userCode,
      'userName': userName,
      'userExternalCode': userExternalCode,
      'userGroupMSTId': userGroupMSTId,
      'userGroupMST': userGroupMST?.toJson(),
      'userRoleMSTId': userRoleMSTId,
      'userRoleMST': userRoleMST?.toJson(),
      'userGroupManagerMSTId': userGroupManagerMSTId,
      'userGroupManagerMST': userGroupManagerMST?.toJson(),
      'gender': gender,
      'primaryContactNumber': primaryContactNumber,
      'secondaryContactNumber': secondaryContactNumber,
      'primaryEmailId': primaryEmailId,
      'secondaryEmailId': secondaryEmailId,
      'profileImage': profileImage,
      'password': password,
      'ipAddress': ipAddress,
      'forgotPasswordOTP': forgotPasswordOTP,
      'forgotPasswordOTPExpiry': forgotPasswordOTPExpiry,
      'ipUser': ipUser,
      'deliveryPerson': deliveryPerson,
      'signUp': signUp,
      'active': active,
    };
  }
}

class UserGroupMST {
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  String? userGroupMSTId;
  String? groupCode;
  String? groupName;
  String? sortOrder;
  bool? systemData;
  bool? active;

  UserGroupMST({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.userGroupMSTId,
    this.groupCode,
    this.groupName,
    this.sortOrder,
    this.systemData,
    this.active,
  });

  factory UserGroupMST.fromJson(Map<String, dynamic> json) {
    return UserGroupMST(
      createdOn: json['createdOn'],
      modifiedOn: json['modifiedOn'],
      createdBy: json['createdBy'],
      modifiedBy: json['modifiedBy'],
      userGroupMSTId: json['userGroupMSTId'],
      groupCode: json['groupCode'],
      groupName: json['groupName'],
      sortOrder: json['sortOrder'],
      systemData: json['systemData'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdOn': createdOn,
      'modifiedOn': modifiedOn,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'userGroupMSTId': userGroupMSTId,
      'groupCode': groupCode,
      'groupName': groupName,
      'sortOrder': sortOrder,
      'systemData': systemData,
      'active': active,
    };
  }
}

class UserRoleMST {
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  String? userRoleMSTId;
  String? roleCode;
  String? roleName;
  String? sortOrder;
  bool? systemData;
  bool? active;

  UserRoleMST({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.userRoleMSTId,
    this.roleCode,
    this.roleName,
    this.sortOrder,
    this.systemData,
    this.active,
  });

  factory UserRoleMST.fromJson(Map<String, dynamic> json) {
    return UserRoleMST(
      createdOn: json['createdOn'],
      modifiedOn: json['modifiedOn'],
      createdBy: json['createdBy'],
      modifiedBy: json['modifiedBy'],
      userRoleMSTId: json['userRoleMSTId'],
      roleCode: json['roleCode'],
      roleName: json['roleName'],
      sortOrder: json['sortOrder'],
      systemData: json['systemData'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdOn': createdOn,
      'modifiedOn': modifiedOn,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'userRoleMSTId': userRoleMSTId,
      'roleCode': roleCode,
      'roleName': roleName,
      'sortOrder': sortOrder,
      'systemData': systemData,
      'active': active,
    };
  }
}

class UserGroupManagerMST {
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  String? userGroupMSTId;
  String? groupCode;
  String? groupName;
  String? sortOrder;
  bool? systemData;
  bool? active;

  UserGroupManagerMST({
    this.createdOn,
    this.modifiedOn,
    this.createdBy,
    this.modifiedBy,
    this.userGroupMSTId,
    this.groupCode,
    this.groupName,
    this.sortOrder,
    this.systemData,
    this.active,
  });

  factory UserGroupManagerMST.fromJson(Map<String, dynamic> json) {
    return UserGroupManagerMST(
      createdOn: json['createdOn'],
      modifiedOn: json['modifiedOn'],
      createdBy: json['createdBy'],
      modifiedBy: json['modifiedBy'],
      userGroupMSTId: json['userGroupMSTId'],
      groupCode: json['groupCode'],
      groupName: json['groupName'],
      sortOrder: json['sortOrder'],
      systemData: json['systemData'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdOn': createdOn,
      'modifiedOn': modifiedOn,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'userGroupMSTId': userGroupMSTId,
      'groupCode': groupCode,
      'groupName': groupName,
      'sortOrder': sortOrder,
      'systemData': systemData,
      'active': active,
    };
  }
}
