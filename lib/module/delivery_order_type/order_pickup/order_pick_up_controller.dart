import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/common_dialog.dart';

class OrderPickUpController extends GetxController {
  RxInt index = 0.obs;



  changeIndex(int index) {
    this.index.value = index;
  }
}
