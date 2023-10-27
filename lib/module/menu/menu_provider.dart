import 'package:flutter/cupertino.dart';
import 'package:pizza/module/menu/menu_repository.dart';

import '../../api/api_services.dart';
import '../../api/api_response.dart';
import 'menu_model.dart';

class MenuProvider extends ChangeNotifier {
  final MenuRepository _repo = MenuRepository();
  List<MenuListModel> menuListModel = [];

  void getMenu() async {
    menuListModel = await _repo.getMenu();
    notifyListeners();
  }
}
