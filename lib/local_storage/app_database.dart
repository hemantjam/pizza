import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/cart_items_dao.dart';
import 'entity/cart_items_entity.dart';
import 'entity/menu_details_entity.dart';
import 'dao/menu_details_dao.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [MenuDetailsEntity,CartItemsEntity])
abstract class AppDatabase extends FloorDatabase {
  MenuDetailsDao get menuDetailsDoa;
  CartItemsDao get cartItemsDoa;
}
