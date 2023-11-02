import 'package:get/get.dart';

import 'all_active_controller.dart';

class AllActiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllActiveController());
  }
}
