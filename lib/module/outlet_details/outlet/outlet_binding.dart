import 'package:get/get.dart';
import 'package:pizza/module/outlet_details/outlet/outlet_controller.dart';

class OutletBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(OutletController());
  }

}