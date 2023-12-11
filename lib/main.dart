import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza/pizza_app.dart';
import 'package:uuid/uuid.dart';
Uuid uuid = const Uuid();

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  //GlobalBindings().dependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
 // Store store = await Object;

  runApp(const PizzaApp());
}
