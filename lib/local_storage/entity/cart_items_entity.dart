import 'package:floor/floor.dart';

@Entity(tableName: "CartItemsEntity")
class CartItemsEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
   String itemName;
   int itemQuantity;
   String selectedBase;
   String selectedSize;
   int addon;
   int total;
   String itemModel;
   String toppings;

  CartItemsEntity({
    required this.toppings,
    required this.itemModel,
    required this.itemName,
    required this.itemQuantity,
    required this.selectedBase,
    required this.selectedSize,
    required this.addon,
    required this.total,
    this.id
  });
}
