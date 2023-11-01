import 'package:get/get.dart';

import 'outlet_shift_details_controller.dart';

class OutletShiftDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OutletShiftDetailsController());
  }
}
