class AddToCartPayload {
  bool? active;
  int? additionalValue;
  String? combSeq;
  int? comboRefId;
  String? cookingInstruction;
  String? displayName;
  int? hnhSurcharge;
  String? id;
  int? itemMSTId;
  int? itemSide;
  String? orderDTLRefId;
  String? orderMSTId;
  List<OrderRecipeItemWebRequestSet>? orderRecipeItemWebRequestSet;
  String? orderStage;
  int? qty;
  int? recipeMSTId;
  int? sortOrder;

  AddToCartPayload({
    this.active,
    this.additionalValue,
    this.combSeq,
    this.comboRefId,
    this.cookingInstruction,
    this.displayName,
    this.hnhSurcharge,
    this.id,
    this.itemMSTId,
    this.itemSide,
    this.orderDTLRefId,
    this.orderMSTId,
    this.orderRecipeItemWebRequestSet,
    this.orderStage,
    this.qty,
    this.recipeMSTId,
    this.sortOrder,
  });

  factory AddToCartPayload.fromMap(Map<String, dynamic> json) => AddToCartPayload(
    active: json["active"],
    additionalValue: json["additionalValue"],
    combSeq: json["combSeq"],
    comboRefId: json["comboRefId"],
    cookingInstruction: json["cookingInstruction"],
    displayName: json["displayName"],
    hnhSurcharge: json["hnhSurcharge"],
    id: json["id"],
    itemMSTId: json["itemMSTId"],
    itemSide: json["itemSide"],
    orderDTLRefId: json["orderDTLRefId"],
    orderMSTId: json["orderMSTId"],
    orderRecipeItemWebRequestSet: json["orderRecipeItemWebRequestSet"] == null
        ? null
        : List<OrderRecipeItemWebRequestSet>.from(json["orderRecipeItemWebRequestSet"].map((x) => OrderRecipeItemWebRequestSet.fromMap(x))),
    orderStage: json["orderStage"],
    qty: json["qty"],
    recipeMSTId: json["recipeMSTId"],
    sortOrder: json["sortOrder"],
  );

  Map<String, dynamic> toMap() => {
    "active": active,
    "additionalValue": additionalValue,
    "combSeq": combSeq,
    "comboRefId": comboRefId,
    "cookingInstruction": cookingInstruction,
    "displayName": displayName,
    "hnhSurcharge": hnhSurcharge,
    "id": id,
    "itemMSTId": itemMSTId,
    "itemSide": itemSide,
    "orderDTLRefId": orderDTLRefId,
    "orderMSTId": orderMSTId,
    "orderRecipeItemWebRequestSet": orderRecipeItemWebRequestSet == null
        ? null
        : List<dynamic>.from(orderRecipeItemWebRequestSet!.map((x) => x.toMap())),
    "orderStage": orderStage,
    "qty": qty,
    "recipeMSTId": recipeMSTId,
    "sortOrder": sortOrder,
  };
}

class OrderRecipeItemWebRequestSet {
  bool? active;
  bool? base;
  int? defaultQty;
  String? id;
  bool? inFirstFour;
  int? itemSide;
  int? qty;
  int? recipeItemDTLId;
  int? sortOrder;

  OrderRecipeItemWebRequestSet({
    this.active,
    this.base,
    this.defaultQty,
    this.id,
    this.inFirstFour,
    this.itemSide,
    this.qty,
    this.recipeItemDTLId,
    this.sortOrder,
  });

  factory OrderRecipeItemWebRequestSet.fromMap(Map<String, dynamic> json) => OrderRecipeItemWebRequestSet(
    active: json["active"],
    base: json["base"],
    defaultQty: json["defaultQty"],
    id: json["id"],
    inFirstFour: json["inFirstFour"],
    itemSide: json["itemSide"],
    qty: json["qty"],
    recipeItemDTLId: json["recipeItemDTLId"],
    sortOrder: json["sortOrder"],
  );

  Map<String, dynamic> toMap() => {
    "active": active,
    "base": base,
    "defaultQty": defaultQty,
    "id": id,
    "inFirstFour": inFirstFour,
    "itemSide": itemSide,
    "qty": qty,
    "recipeItemDTLId": recipeItemDTLId,
    "sortOrder": sortOrder,
  };
}
