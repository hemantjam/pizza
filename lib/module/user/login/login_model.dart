
class UserDataModel  {
  String? message;
  bool? status;
  UserDataDetails? data;

  UserDataModel({
    this.message,
    this.status,
    this.data,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null ? UserDataDetails.fromJson(json['data']) : null,
    );
  }
}

class UserDataDetails {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? jwtToken;
  UserMST? userMST;

  UserDataDetails({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.emailId,
    this.mobileNumber,
    this.jwtToken,
    this.userMST,
  });

  factory UserDataDetails.fromJson(Map<String, dynamic> json) {
    return UserDataDetails(
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
}

class UserMST {
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  int? userMSTId;
  String? userCode;
  String? userName;
  String? userExternalCode;
  int? userGroupMSTId;
  UserGroupMST? userGroupMST;
  int? userRoleMSTId;
  UserRoleMST? userRoleMST;
  int? userGroupManagerMSTId;
  UserGroupManagerMST? userGroupManagerMST;
  String? gender;
  String? primaryContactNumber;
  String? secondaryContactNumber;
  String? primaryEmailId;
  String? secondaryEmailId;
  String? profileImage;
  String? password;
  String? invoiceDiscountLimit;
  String? dueBalance;
  String? ipAddress;
  String? forgotPasswordOTP;
  String? forgotPasswordOTPExpiry;
  List<dynamic>? userOutletAccessDTLList;
  List<dynamic>? userAddressMSTList;
  bool? lock;
  bool? ipUser;
  String? deliveryPerson;
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
    this.invoiceDiscountLimit,
    this.dueBalance,
    this.ipAddress,
    this.forgotPasswordOTP,
    this.forgotPasswordOTPExpiry,
    this.userOutletAccessDTLList,
    this.userAddressMSTList,
    this.lock,
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
      invoiceDiscountLimit: json['invoiceDiscountLimit'],
      dueBalance: json['dueBalance'],
      ipAddress: json['ipAddress'],
      forgotPasswordOTP: json['forgotPasswordOTP'],
      forgotPasswordOTPExpiry: json['forgotPasswordOTPExpiry'],
      userOutletAccessDTLList: json['userOutletAccessDTLList'],
      userAddressMSTList: json['userAddressMSTList'],
      lock: json['lock'],
      ipUser: json['ipUser'],
      deliveryPerson: json['deliveryPerson'],
      signUp: json['signUp'],
      active: json['active'],
    );
  }
}

class UserGroupMST {
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  int? userGroupMSTId;
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
}

class UserRoleMST {
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  int? userRoleMSTId;
  String? roleCode;
  String? roleName;
  int? sortOrder;
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
}

class UserGroupManagerMST {
  String? createdOn;
  String? modifiedOn;
  String? createdBy;
  String? modifiedBy;
  int? userGroupMSTId;
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
}
