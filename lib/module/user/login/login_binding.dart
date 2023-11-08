import 'package:get/get.dart';
import 'package:pizza/module/user/login/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}