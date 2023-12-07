// dao/person_dao.dart

import 'package:floor/floor.dart';

import '../entity/menu_details_entity.dart';

@dao
abstract class MenuDetailsDao {
  @Query('SELECT * FROM MenuDetailsEntity WHERE groupName = :groupName')
  Future<MenuDetailsEntity?> findGroupDataByName(String groupName);

  @Query('SELECT * FROM MenuDetailsEntity')
  Future<List<MenuDetailsEntity>> findAllMenuDetails();

  @insert
  Future<void> insertGroupData(MenuDetailsEntity menuDetailsTable);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMenuDetails(MenuDetailsEntity menuDetailsTable);

  @delete
  Future<void> deleteSingleMenuDetails(MenuDetailsEntity menuDetailsTable);

  @delete
  Future<int> deleteAllMenu(List<MenuDetailsEntity> menuDetailsTable);
}
