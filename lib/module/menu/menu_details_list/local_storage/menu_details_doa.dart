// dao/person_dao.dart

import 'package:floor/floor.dart';

import '../all_menu_page.dart';
import 'menu_details.dart';
@dao
abstract class MenuDetailsDoa {
  @Query('SELECT * FROM MenuDetailsTable WHERE groupName = :groupName')
  Future<MenuDetailsTable?> findGroupDataByName(String groupName);
  @Query('SELECT * FROM MenuDetailsTable')
  Future<List<MenuDetailsTable>> findAllMenuDetails();
  @insert
  Future<void> insertGroupData(MenuDetailsTable menuDetailsTable); // Change the parameter name to menuDetails
}