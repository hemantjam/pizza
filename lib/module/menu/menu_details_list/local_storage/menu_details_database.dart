// database.dart

// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'menu_details.dart';
import 'menu_details_doa.dart';

part 'menu_details_database.g.dart';

@Database(version: 1, entities: [MenuDetailsTable])
abstract class AppDatabase extends FloorDatabase {
  MenuDetailsDoa get menuDetailsDoa;
}
