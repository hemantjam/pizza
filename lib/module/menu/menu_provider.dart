import 'package:flutter/cupertino.dart';

import '../../api/api_client.dart';
import '../../api/api_response.dart';
import 'menu_model.dart';

class MenuProvider extends ChangeNotifier {
  MenuProvider() {
    getMenu();
  }


  List<MenuListModel> menuListModel = [];

void getMenu(){}
}
