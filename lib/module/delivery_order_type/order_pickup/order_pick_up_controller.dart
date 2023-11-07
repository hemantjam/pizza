import 'package:get/get.dart';

class OrderPickUpController extends GetxController {
  RxInt index = 0.obs;

  changeIndex(int index) {
    this.index.value = index;
  }
}
