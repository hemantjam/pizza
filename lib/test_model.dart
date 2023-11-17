/*
class MenuResponseModel {
  String? message;
  bool? status;
  Map<String, GroupModel>? data;

  MenuResponseModel({this.message, this.status, this.data});

  factory MenuResponseModel.fromJson(Map<String, dynamic> json) {
    return MenuResponseModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null
          ? Map<String, GroupModel>.from(
              (json['data'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(key, GroupModel.fromJson(value)),
              ),
            )
          : null,
    );
  }
}

class GroupModel {
  GroupDetailsModel? group;
  Map<String, RecipeDetailsModel>? items;

  GroupModel({this.group, this.items});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      group: json['group'] != null
          ? GroupDetailsModel.fromJson(json['group'])
          : null,
      items: json['items'] != null
          ? Map<String, RecipeDetailsModel>.from(
              (json['items'] as Map<String, dynamic>).map(
                (key, value) =>
                    MapEntry(key, RecipeDetailsModel.fromJson(value)),
              ),
            )
          : null,
    );
  }
}
class GroupDetailsModel {
  int? itemGroupMSTId;
  int? itemDivisionMSTId;
  ItemDivisionModel? itemDivisionMST;
  String? itemGroupCode;
  String? itemGroupName;
  bool? webDisplay;
  int? sortOrder;

  GroupDetailsModel({
    this.itemGroupMSTId,
    this.itemDivisionMSTId,
    this.itemDivisionMST,
    this.itemGroupCode,
    this.itemGroupName,
    this.webDisplay,
    this.sortOrder,
  });

  factory GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    return GroupDetailsModel(
      itemGroupMSTId: json['itemGroupMSTId'],
      itemDivisionMSTId: json['itemDivisionMSTId'],
      itemDivisionMST: json['itemDivisionMST'] != null
          ? ItemDivisionModel.fromJson(json['itemDivisionMST'])
          : null,
      itemGroupCode: json['itemGroupCode'],
      itemGroupName: json['itemGroupName'],
      webDisplay: json['webDisplay'],
      sortOrder: json['sortOrder'],
    );
  }
}

class ItemDivisionModel {
  int? itemDivisionMSTId;
  String? itemDivisionCode;
  String? itemDivisionName;
  int? sortOrder;

  ItemDivisionModel({
    this.itemDivisionMSTId,
    this.itemDivisionCode,
    this.itemDivisionName,
    this.sortOrder,
  });

  factory ItemDivisionModel.fromJson(Map<String, dynamic> json) {
    return ItemDivisionModel(
      itemDivisionMSTId: json['itemDivisionMSTId'],
      itemDivisionCode: json['itemDivisionCode'],
      itemDivisionName: json['itemDivisionName'],
      sortOrder: json['sortOrder'],
    );
  }
}
class RecipeDetailsModel {
  List<RecipeModel>? recipes;
  List<AvailableSizesModel>? availableSizes;
  List<CategoryModel>? availableCategories;
  String? name;
  String? shortName;
  bool? isHnh;
  bool? isNew;
  String? image;
  String? ingredients;
  int? id;
  bool? stockAvailable;
  bool? isActive;

  RecipeDetailsModel({
    this.recipes,
    this.availableSizes,
    this.availableCategories,
    this.name,
    this.shortName,
    this.isHnh,
    this.isNew,
    this.image,
    this.ingredients,
    this.id,
    this.stockAvailable,
    this.isActive,
    // Add other properties here
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsModel(
      recipes: json['recipes'] != null
          ? List<RecipeModel>.from(
        (json['recipes'] as List<dynamic>).map(
              (item) => RecipeModel.fromJson(item),
        ),
      )
          : null,
      availableSizes: json['availableSizes'] != null
          ? List<AvailableSizesModel>.from(
        (json['availableSizes'] as List<dynamic>).map(
              (item) => AvailableSizesModel.fromJson(item),
        ),
      )
          : null,
      availableCategories: json['availableCategories'] != null
          ? List<CategoryModel>.from(
        (json['availableCategories'] as List<dynamic>).map(
              (item) => CategoryModel.fromJson(item),
        ),
      )
          : null,
      name: json['name'],
      shortName: json['shortName'],
      isHnh: json['isHnh'],
      isNew: json['isNew'],
      image: json['image'],
      ingredients: json['ingredients'],
      id: json['id'],
      stockAvailable: json['stockAvailable'],
      isActive: json['isActive'],
      // Add other property mappings
    );
  }
}


class RecipeModel {
  Map<String, dynamic>? size;
  Map<String, dynamic>? sauce;
  Map<String, dynamic>? base;
  List<ToppingsModel>? toppings;
  ToppingsInfoModel? toppingsInfo;

  RecipeModel({
    this.size,
    this.sauce,
    this.base,
    this.toppings,
    this.toppingsInfo,
    // Add other properties here
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      size: json['size'],
      sauce: json['sauce'],
      base: json['base'],
      toppings: json['toppings'] != null
          ? List<ToppingsModel>.from(
              (json['toppings'] as List<dynamic>).map(
                (item) => ToppingsModel.fromJson(item),
              ),
            )
          : null,
      toppingsInfo: json['toppingsInfo'] != null
          ? ToppingsInfoModel.fromJson(json['toppingsInfo'])
          : null,
      // Add other property mappings
    );
  }
}

class AvailableSizesModel {
  int? sortOrder;
  String? name;
  int? id;

  AvailableSizesModel({this.sortOrder, this.name, this.id});

  factory AvailableSizesModel.fromJson(Map<String, dynamic> json) {
    return AvailableSizesModel(
      sortOrder: json['sortOrder'],
      name: json['name'],
      id: json['id'],
    );
  }
}

class CategoryModel {
  int? sortOrder;
  String? name;
  int? id;

  CategoryModel({this.sortOrder, this.name, this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      sortOrder: json['sortOrder'],
      name: json['name'],
      id: json['id'],
    );
  }
}

class ToppingsModel {
  String? name;
  bool? stockAvailable;
  String? image;
  int? id;
  double? addCost;
  double? defaultQuantity;
  double? itemQuantity;
  double? minimumQuantity;
  double? maximumQuantity;

  ToppingsModel({
    this.name,
    this.stockAvailable,
    this.image,
    this.id,
    this.addCost,
    this.defaultQuantity,
    this.itemQuantity,
    this.minimumQuantity,
    this.maximumQuantity,
  });

  factory ToppingsModel.fromJson(Map<String, dynamic> json) {
    return ToppingsModel(
      name: json['name'],
      stockAvailable: json['stockAvailable'],
      image: json['image'],
      id: json['id'],
      addCost: json['addCost'],
      defaultQuantity: json['defaultQuantity'],
      itemQuantity: json['itemQuantity'],
      minimumQuantity: json['minimumQuantity'],
      maximumQuantity: json['maximumQuantity'],
    );
  }
}

class ToppingsInfoModel {
  QuantityInfoModel? sauce;
  QuantityInfoModel? toppings;

  ToppingsInfoModel({this.sauce, this.toppings});

  factory ToppingsInfoModel.fromJson(Map<String, dynamic> json) {
    return ToppingsInfoModel(
      sauce: json['Sauce'] != null
          ? QuantityInfoModel.fromJson(json['Sauce'])
          : null,
      toppings: json['Toppings'] != null
          ? QuantityInfoModel.fromJson(json['Toppings'])
          : null,
    );
  }
}

class QuantityInfoModel {
  double? maximumQuantity;
  double? minimumQuantity;

  QuantityInfoModel({this.maximumQuantity, this.minimumQuantity});

  factory QuantityInfoModel.fromJson(Map<String, dynamic> json) {
    return QuantityInfoModel(
      maximumQuantity: json['maximumQuantity'],
      minimumQuantity: json['minimumQuantity'],
    );
  }
}
*/