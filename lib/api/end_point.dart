class ApiEndPoints {
  static const String getMenu = "homeController/menus/";
  static const String loginByIp =
      "login/byIp/"; // call this api when user open app first time
  static const String addToken =
      "addIntoToken/system"; // call this api after "callbyip" API and add token also will get token to further API access
}
