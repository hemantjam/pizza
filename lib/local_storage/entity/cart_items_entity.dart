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
  int basePrice;
  String itemModel;
  String orderCreateResponse;
  bool isOffer;

  CartItemsEntity({
    required this.orderCreateResponse,
    required this.itemModel,
    required this.itemName,
    required this.itemQuantity,
    required this.selectedBase,
    required this.selectedSize,
    required this.addon,
    required this.basePrice,
    required this.isOffer,
    this.id,
  });
}
