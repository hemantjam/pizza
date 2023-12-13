class ApiEndPoints {
  /// base url
  static const baseUrl = 'https://tomcat.harvices.com/POSLocalAPI/';
  static String authToken = "";

  /// end-points
  static const String getMenu = "homeController/menus";
  static const String loginByIp = "userMST/login/byIp/";

  static const String register = "customerMST/signUpCustomer/";
  static const String addIntoSystem = "/userMST/addIntoToken/system";
  static const String addIntoOutlet = "/userMST/addIntoToken/outlet";
  static const String userLogin = "userMST/login/";
  static const String userLoggedIn = "userMST/loggedInUser/";
  static const String forgotPassword = "userMST/forgotPassword/";
  static const String resetPassword = "userMST/resetPassword/";
  static const String offerList = "homeController/offers";
  static const String offerInfo = "homeController/offersinfo/";
  static const String outletShiftDetails = "outletShiftDTL/byOutletSystem/";
  static const String allActiveOutlet = "geographyMST/allActive/";
  static const String geographyByTypeCode = "geographyMST/byTypeCode/";
  static const String outletDetailsByCode = "outletMST/code/";
  static const String orderMasterCreate = "orderMST/create/";
  static const String orderDetailsCreate = "orderDTL/create/";
  static const String notifySSE = "orderMST/notifySSE/";

  /// menu
  static const String getMenuByCode = "itemMST/byGroupCode/";
}

/* https://tomcat.harvices.com/POSLocalAPI/userMST/addIntoToken/outlet
//https://tomcat.harvices.com/POSLocalAPI/outletMST/code/RJT01
  https://tomcat.harvices.com/POSLocalAPI/userMST/loggedInUser/
  https://tomcat.harvices.com/POSLocalAPI/userMST/addIntoToken/system
  https://tomcat.harvices.com/POSLocalAPI/outletShiftDTL/byOutletSystem/
  https://tomcat.harvices.com/POSLocalAPI/geographyMST/allActive/
  https://tomcat.harvices.com/POSLocalAPI/outletMST/code/RJT01
  https://tomcat.harvices.com/POSLocalAPI/homeController/popular
  https://tomcat.harvices.com/POSLocalAPI/itemMST/byGroupCode/ */
