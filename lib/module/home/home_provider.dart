import 'package:flutter/cupertino.dart';
import 'dart:developer';
class HomeProvider extends ChangeNotifier {
  HomeProvider(){
    log("----->");
  }
  bool showHeader = false;

  toggleHeaderOptions() {
    showHeader = !showHeader;
    notifyListeners();
  }
}
