import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza/pizza_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const PizzaApp());
}
