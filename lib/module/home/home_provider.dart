import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  bool showHeader = false;

  toggleHeaderOptions() {
    showHeader = !showHeader;
    notifyListeners();
  }
}
