class MenuGroupCodeModel {
  String? message;
  bool? status;
  Map<String, GroupModel>? data;

  MenuGroupCodeModel({this.message, this.status, this.data});

  factory MenuGroupCodeModel.fromJson(Map<String, dynamic> json) {
    return MenuGroupCodeModel(
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

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data?.map((key, value) => MapEntry(key, value?.toJson())),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'group': group?.toJson(),
      'items': items?.map((key, value) => MapEntry(key, value?.toJson())),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'itemGroupMSTId': itemGroupMSTId,
      'itemDivisionMSTId': itemDivisionMSTId,
      'itemDivisionMST': itemDivisionMST?.toJson(),
      'itemGroupCode': itemGroupCode,
      'itemGroupName': itemGroupName,
      'webDisplay': webDisplay,
      'sortOrder': sortOrder,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'itemDivisionMSTId': itemDivisionMSTId,
      'itemDivisionCode': itemDivisionCode,
      'itemDivisionName': itemDivisionName,
      'sortOrder': sortOrder,
    };
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
  Dietary? dietary;

  RecipeDetailsModel(
      {this.recipes,
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
      this.dietary});

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsModel(
        recipes: json['recipes'] != null
            ? (json['recipes'] as List<dynamic>).map(
                (item) {
                  final Map<String, dynamic> recipeMap = item.values.first;
                  recipeMap['name'] = item.keys.first;
                  return RecipeModel.fromJson(recipeMap);
                },
              ).toList()??[]
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
        dietary:
            json["dietary"] != null ? Dietary.fromJson(json["dietary"]) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'recipes': recipes?.map((recipe) => recipe.toJson()).toList(),
      'availableSizes': availableSizes?.map((size) => size.toJson()).toList(),
      'availableCategories':
          availableCategories?.map((category) => category.toJson()).toList(),
      'name': name,
      'shortName': shortName,
      'isHnh': isHnh,
      'isNew': isNew,
      'image': image,
      'ingredients': ingredients,
      'id': id,
      'stockAvailable': stockAvailable,
      'isActive': isActive,
      'dietary': dietary?.toJson(),
    };
  }
}

class RecipeModel {
  AvailableSizesModel? size;
  List<SauceModel>? sauce;
  List<BaseModel>? base;
  List<ToppingsModel>? toppings;
  ToppingsInfoModel? toppingsInfo;
  double? basePrice;
  String? description;
  int? id;
  bool? isActive;
  bool? stockAvailable;
  double? tax;

  RecipeModel({
    this.size,
    this.sauce,
    this.base,
    this.toppings,
    this.toppingsInfo,
    this.id,
    this.description,
    this.basePrice,
    this.isActive,
    this.stockAvailable,
    this.tax,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      size: json['Size'] != null
          ? AvailableSizesModel.fromJson(json['Size'])
          : null,
      sauce: json['Sauce'] != null
          ? List<SauceModel>.from(
              (json['Sauce'] as List<dynamic>).map(
                (item) => SauceModel.fromJson(item),
              ),
            )
          : null,
      base: json['Base'] != null
          ? List<BaseModel>.from(
              (json['Base'] as List<dynamic>).map(
                (item) => BaseModel.fromJson(item),
              ),
            )
          : null,
      toppings: json['Toppings'] != null
          ? List<ToppingsModel>.from(
              (json['Toppings'] as List<dynamic>).map(
                (item) => ToppingsModel.fromJson(item),
              ),
            )
          : null,
      toppingsInfo: json['toppingsInfo'] != null
          ? ToppingsInfoModel.fromJson(json['toppingsInfo'])
          : null,
      id: json['id'],
      description: json['description'],
      basePrice: json['basePrice'],
      isActive: json['isActive'],
      stockAvailable: json['stockAvailable'],
      tax: json['tax'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Size': size?.toJson(),
      'Sauce': sauce?.map((sauce) => sauce.toJson()).toList(),
      'Base': base?.map((base) => base.toJson()).toList(),
      'Toppings': toppings?.map((topping) => topping.toJson()).toList(),
      'toppingsInfo': toppingsInfo?.toJson(),
      'id': id,
      'description': description,
      'basePrice': basePrice,
      'isActive': isActive,
      'stockAvailable': stockAvailable,
      'tax': tax,
    };
  }
}

class BaseModel {
  String? name;
  int? sortOrder;
  String? image;
  bool? stockAvailable;
  int? id;
  double? addCost;
  double? defaultQuantity;
  double? itemQuantity;
  double? minimumQuantity;
  double? maximumQuantity;

  BaseModel({
    this.name,
    this.sortOrder,
    this.image,
    this.stockAvailable,
    this.id,
    this.addCost,
    this.defaultQuantity,
    this.itemQuantity,
    this.minimumQuantity,
    this.maximumQuantity,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      name: json['name'],
      sortOrder: json['sortOrder'],
      image: json['image'],
      stockAvailable: json['stockAvailable'],
      id: json['id'],
      addCost: json['addCost'],
      defaultQuantity: json['defaultQuantity'],
      itemQuantity: json['itemQuantity'],
      minimumQuantity: json['minimumQuantity'],
      maximumQuantity: json['maximumQuantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sortOrder': sortOrder,
      'image': image,
      'stockAvailable': stockAvailable,
      'id': id,
      'addCost': addCost,
      'defaultQuantity': defaultQuantity,
      'itemQuantity': itemQuantity,
      'minimumQuantity': minimumQuantity,
      'maximumQuantity': maximumQuantity,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'sortOrder': sortOrder,
      'name': name,
      'id': id,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'sortOrder': sortOrder,
      'name': name,
      'id': id,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'stockAvailable': stockAvailable,
      'image': image,
      'id': id,
      'addCost': addCost,
      'defaultQuantity': defaultQuantity,
      'itemQuantity': itemQuantity,
      'minimumQuantity': minimumQuantity,
      'maximumQuantity': maximumQuantity,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'Sauce': sauce?.toJson(),
      'Toppings': toppings?.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'maximumQuantity': maximumQuantity,
      'minimumQuantity': minimumQuantity,
    };
  }
}

class Dietary {
  int? id;
  String? symbol;
  String? name;

  Dietary({this.id, this.name, this.symbol});

  factory Dietary.fromJson(Map<String, dynamic> json) {
    return Dietary(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
    };
  }
}

class SauceModel {
  String? name;
  bool? stockAvailable;
  String? image;
  int? id;
  double? addCost;
  double? defaultQuantity;
  double? itemQuantity;
  double? minimumQuantity;
  double? maximumQuantity;

  SauceModel({
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

  factory SauceModel.fromJson(Map<String, dynamic> json) {
    return SauceModel(
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'stockAvailable': stockAvailable,
      'image': image,
      'id': id,
      'addCost': addCost,
      'defaultQuantity': defaultQuantity,
      'itemQuantity': itemQuantity,
      'minimumQuantity': minimumQuantity,
      'maximumQuantity': maximumQuantity,
    };
  }
}
