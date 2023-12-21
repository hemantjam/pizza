// dao/person_dao.dart

import 'package:floor/floor.dart';

import '../entity/order_create_response_entity.dart';

@dao
abstract class OrderCreateResponseDoa {
  @Query('SELECT * FROM OrderCreateResponseEntity WHERE resId = :id')
  Future<OrderCreateResponseEntity?> findById(String id);

  @Query('SELECT * FROM OrderCreateResponseEntity')
  Future<List<OrderCreateResponseEntity>> findAll();

  @insert
  Future<void> insertResData(
      OrderCreateResponseEntity orderCreateResponseEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateResData(
      OrderCreateResponseEntity orderCreateResponseEntity);

  @delete
  Future<void> deleteSingleResData(
      OrderCreateResponseEntity orderCreateResponseEntity);

  @delete
  Future<int> deleteAllResData(
      List<OrderCreateResponseEntity> orderCreateResponseEntities);
}
