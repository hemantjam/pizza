class TestMenuGroupCodeModel {
  String? message;
  bool? status;
  Map<String, TestGroupModel>? data;

  TestMenuGroupCodeModel({this.message, this.status, this.data});

  factory TestMenuGroupCodeModel.fromJson(Map<String, dynamic> json) {
    return TestMenuGroupCodeModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null
          ? Map<String, TestGroupModel>.from(
        (json['data'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, TestGroupModel.fromJson(value)),
        ),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class TestGroupModel {
  TestGroupDetailsModel? group;
  Map<String, TestRecipeDetailsModel>? items;

  TestGroupModel({this.group, this.items});

  factory TestGroupModel.fromJson(Map<String, dynamic> json) {
    return TestGroupModel(
      group: json['group'] != null
          ? TestGroupDetailsModel.fromJson(json['group'])
          : null,
      items: json['items'] != null
          ? Map<String, TestRecipeDetailsModel>.from(
        (json['items'] as Map<String, dynamic>).map(
              (key, value) =>
              MapEntry(key, TestRecipeDetailsModel.fromJson(value)),
        ),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group': group?.toJson(),
      'items': items?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class TestGroupDetailsModel {
  int? itemGroupMSTId;
  int? itemDivisionMSTId;
  TestItemDivisionModel? itemDivisionMST;
  String? itemGroupCode;
  String? itemGroupName;
  bool? webDisplay;
  int? sortOrder;

  TestGroupDetailsModel({
    this.itemGroupMSTId,
    this.itemDivisionMSTId,
    this.itemDivisionMST,
    this.itemGroupCode,
    this.itemGroupName,
    this.webDisplay,
    this.sortOrder,
  });

  factory TestGroupDetailsModel.fromJson(Map<String, dynamic> json) {
    return TestGroupDetailsModel(
      itemGroupMSTId: json['itemGroupMSTId'],
      itemDivisionMSTId: json['itemDivisionMSTId'],
      itemDivisionMST: json['itemDivisionMST'] != null
          ? TestItemDivisionModel.fromJson(json['itemDivisionMST'])
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

class TestItemDivisionModel {
  int? itemDivisionMSTId;
  String? itemDivisionCode;
  String? itemDivisionName;
  int? sortOrder;

  TestItemDivisionModel({
    this.itemDivisionMSTId,
    this.itemDivisionCode,
    this.itemDivisionName,
    this.sortOrder,
  });

  factory TestItemDivisionModel.fromJson(Map<String, dynamic> json) {
    return TestItemDivisionModel(
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

class TestRecipeDetailsModel {
  List<TestRecipeModel>? recipes;
  List<TestAvailableSizesModel>? availableSizes;
  List<TestCategoryModel>? availableCategories;
  String? name;
  String? shortName;
  bool? isHnh;
  bool? isNew;
  String? image;
  String? ingredients;
  int? id;
  bool? stockAvailable;
  bool? isActive;
  TestDietary? dietary;

  TestRecipeDetailsModel(
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

  factory TestRecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return TestRecipeDetailsModel(
        recipes: json['recipes'] != null
            ? (json['recipes'] as List<dynamic>).map(
              (item) {
           // final Map<String, dynamic> recipeMap = item.values.first;
            //recipeMap['name'] = item.keys.first;
            return TestRecipeModel.fromJson(item);
          },
        ).toList()
            : null,
        availableSizes: json['availableSizes'] != null
            ? List<TestAvailableSizesModel>.from(
          (json['availableSizes'] as List<dynamic>).map(
                (item) => TestAvailableSizesModel.fromJson(item),
          ),
        )
            : null,
        availableCategories: json['availableCategories'] != null
            ? List<TestCategoryModel>.from(
          (json['availableCategories'] as List<dynamic>).map(
                (item) => TestCategoryModel.fromJson(item),
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
        json["dietary"] != null ? TestDietary.fromJson(json["dietary"]) : null);
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

class TestRecipeModel {
  TestAvailableSizesModel? size;
  List<TestSauceModel>? sauce;
  List<TestBaseModel>? base;
  List<TestToppingsModel>? toppings;
  TestToppingsInfoModel? toppingsInfo;
  double? basePrice;
  String? description;
  int? id;
  bool? isActive;
  bool? stockAvailable;
  double? tax;

  TestRecipeModel({
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

  factory TestRecipeModel.fromJson(Map<String, dynamic> json) {
    return TestRecipeModel(
      size: json['Size'] != null
          ? TestAvailableSizesModel.fromJson(json['Size'])
          : null,
      sauce: json['Sauce'] != null
          ? List<TestSauceModel>.from(
        (json['Sauce'] as List<dynamic>).map(
              (item) => TestSauceModel.fromJson(item),
        ),
      )
          : null,
      base: json['Base'] != null
          ? List<TestBaseModel>.from(
        (json['Base'] as List<dynamic>).map(
              (item) => TestBaseModel.fromJson(item),
        ),
      )
          : null,
      toppings: json['Toppings'] != null
          ? List<TestToppingsModel>.from(
        (json['Toppings'] as List<dynamic>).map(
              (item) => TestToppingsModel.fromJson(item),
        ),
      )
          : null,
      toppingsInfo: json['toppingsInfo'] != null
          ? TestToppingsInfoModel.fromJson(json['toppingsInfo'])
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

class TestBaseModel {
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

  TestBaseModel({
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

  factory TestBaseModel.fromJson(Map<String, dynamic> json) {
    return TestBaseModel(
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

class TestAvailableSizesModel {
  int? sortOrder;
  String? name;
  int? id;

  TestAvailableSizesModel({this.sortOrder, this.name, this.id});

  factory TestAvailableSizesModel.fromJson(Map<String, dynamic> json) {
    return TestAvailableSizesModel(
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

class TestCategoryModel {
  int? sortOrder;
  String? name;
  int? id;

  TestCategoryModel({this.sortOrder, this.name, this.id});

  factory TestCategoryModel.fromJson(Map<String, dynamic> json) {
    return TestCategoryModel(
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

class TestToppingsModel {
  String? name;
  bool? stockAvailable;
  String? image;
  int? id;
  double? addCost;
  double? defaultQuantity;
  double? itemQuantity;
  double? minimumQuantity;
  double? maximumQuantity;

  TestToppingsModel({
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

  factory TestToppingsModel.fromJson(Map<String, dynamic> json) {
    return TestToppingsModel(
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

class TestToppingsInfoModel {
  TestQuantityInfoModel? sauce;
  TestQuantityInfoModel? toppings;

  TestToppingsInfoModel({this.sauce, this.toppings});

  factory TestToppingsInfoModel.fromJson(Map<String, dynamic> json) {
    return TestToppingsInfoModel(
      sauce: json['Sauce'] != null
          ? TestQuantityInfoModel.fromJson(json['Sauce'])
          : null,
      toppings: json['Toppings'] != null
          ? TestQuantityInfoModel.fromJson(json['Toppings'])
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

class TestQuantityInfoModel {
  double? maximumQuantity;
  double? minimumQuantity;

  TestQuantityInfoModel({this.maximumQuantity, this.minimumQuantity});

  factory TestQuantityInfoModel.fromJson(Map<String, dynamic> json) {
    return TestQuantityInfoModel(
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

class TestDietary {
  int? id;
  String? symbol;
  String? name;

  TestDietary({this.id, this.name, this.symbol});

  factory TestDietary.fromJson(Map<String, dynamic> json) {
    return TestDietary(
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

class TestSauceModel {
  String? name;
  bool? stockAvailable;
  String? image;
  int? id;
  double? addCost;
  double? defaultQuantity;
  double? itemQuantity;
  double? minimumQuantity;
  double? maximumQuantity;

  TestSauceModel({
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

  factory TestSauceModel.fromJson(Map<String, dynamic> json) {
    return TestSauceModel(
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
