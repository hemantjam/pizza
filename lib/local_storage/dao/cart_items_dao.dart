import 'package:floor/floor.dart';

import '../entity/cart_items_entity.dart';
@dao
abstract class CartItemsDao {
  @Query('SELECT * FROM CartItemsEntity')
  Future<List<CartItemsEntity>> findAllCartItems();

  @insert
  Future<void> insertCartItem(CartItemsEntity cartItemsEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void>updateCartItem(CartItemsEntity cartItemEntity);

  @delete
  Future<void> deleteSingleCartItem(CartItemsEntity cartItemEntity);

  @delete
  Future<int> deleteAllCart(List<CartItemsEntity> cartItemsEntity);
}
