class ToppingsSelection {
  int? toppingId;
  String? toppingName;
  bool? isSelected;
  bool? isDefault;
  int? itemQuantity;
  List<bool?>? values;
  int? defaultQuantity;
  int? maximumQuantity;
  double? addCost;
  bool? canRemove;

  ToppingsSelection({
    required this.canRemove,
    required this.values,
    required this.defaultQuantity,
    required this.isDefault,
    required this.toppingName,
    required this.isSelected,
    required this.toppingId,
    required this.itemQuantity,
    required this.addCost,
    required this.maximumQuantity,
  });
  factory ToppingsSelection.fromJson(Map<String, dynamic> json) => ToppingsSelection(
    canRemove: json['canRemove'] ,
    values: (json['values'] as List<dynamic>?)?.map((e) => e as bool).toList(),
    defaultQuantity: json['defaultQuantity'] ,
    isDefault: json['isDefault'],
    toppingName: json['toppingName'],
    isSelected: json['isSelected'] ,
    toppingId: json['toppingId'],
    itemQuantity: json['itemQuantity'] ,
    addCost: json['addCost'],
    maximumQuantity: json['maximumQuantity'] ,
  );

  Map<String, dynamic> toJson() => {
    'canRemove': canRemove,
    'values': values,
    'defaultQuantity': defaultQuantity,
    'isDefault': isDefault,
    'toppingName': toppingName,
    'isSelected': isSelected,
    'toppingId': toppingId,
    'itemQuantity': itemQuantity,
    'addCost': addCost,
    'maximumQuantity': maximumQuantity,
  };
}