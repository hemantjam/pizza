import 'package:get/get.dart';

class OrderDeliveryController extends GetxController {
  RxInt index = 0.obs;

  changeIndex(int index) {
    this.index.value = index;
  }
}
