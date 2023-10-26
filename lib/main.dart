import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza/pizza_app.dart';

import 'module/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const PizzaApp());
}
