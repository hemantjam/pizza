import 'package:floor/floor.dart';

@entity
class CartItemsEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String itemName;
  final int itemQuantity;
  final String selectedBase;
  final String selectedSize;
  final int addon;
  final int total;
  final String itemModel;
  final String toppings;

  CartItemsEntity({
    required this.toppings,
    required this.itemModel,
    required this.itemName,
    required this.itemQuantity,
    required this.selectedBase,
    required this.selectedSize,
    required this.addon,
    required this.total,
  });
}
