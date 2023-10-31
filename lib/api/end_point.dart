class ApiEndPoints {
  /// base url
  static const baseUrl = 'https://tomcat.harvices.com/POSLocalAPI/';
  static String authToken = "";

  /// end-points
  static const String getMenu = "homeController/menus";
  static const String loginByIp = "userMST/login/byIp/";

  //static const String addToken = "addIntoToken/system";
  static const String addIntoPizza = "/userMST/addIntoToken/pizzaportal";
  static const String rjt01 = "/userMST/addIntoToken/rjt01";

  static const String offerList = "homeController/offers";
  static const String offerInfo = "homeController/offersinfo/";
}

/* https://tomcat.harvices.com/POSLocalAPI/userMST/addIntoToken/outlet

  https://tomcat.harvices.com/POSLocalAPI/userMST/loggedInUser/
  https://tomcat.harvices.com/POSLocalAPI/userMST/addIntoToken/system
  https://tomcat.harvices.com/POSLocalAPI/outletShiftDTL/byOutletSystem/
  https://tomcat.harvices.com/POSLocalAPI/geographyMST/allActive/
  https://tomcat.harvices.com/POSLocalAPI/outletMST/code/RJT01
  https://tomcat.harvices.com/POSLocalAPI/homeController/popular
  https://tomcat.harvices.com/POSLocalAPI/itemMST/byGroupCode/ */
