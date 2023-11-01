import 'package:get/get.dart';
import 'package:pizza/module/home/geoghyaphy/all_active_controller.dart';

class AllActiveBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(AllActiveController());
  }

}