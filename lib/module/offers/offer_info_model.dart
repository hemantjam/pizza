import 'dart:developer';

/*class OfferInfoModel {
  String? message;
  bool? status;
  Data? data;

  OfferInfoModel({
    this.message,
    this.status,
    this.data,
  });

  factory OfferInfoModel.fromJson(Map<String, dynamic> json) {
    return OfferInfoModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      data: Data.fromJson(json['data'] as Map<String, dynamic>?),
    );
  }
}*/

class OfferInfoModel {
  List<SingleOfferInfoModel>? offers;
  int? totalRows;

  OfferInfoModel({
    this.offers,
    this.totalRows,
  });

  factory OfferInfoModel.fromJson(Map<String, dynamic>? json) {
//Map<String,dynamic>d=json?["data"];
//log("------>${d["data"].toString()}");
    List<dynamic>? offersList = json?['data'] ;

    List<SingleOfferInfoModel>? offers = offersList?.map((e) => SingleOfferInfoModel.fromJson(e as Map<String, dynamic>)).toList();

    return OfferInfoModel(
      offers: offers,
      totalRows: json?['totalRows'] as int?,
    );
  }
}

class SingleOfferInfoModel {
  int? id;
  String? offerName;
  String? offerCode;
  String? description; // Corrected the field name
  String? image;
  double? price;
  double? tax;
  double? priceWithTax;
  bool? inStock;
  dynamic recipeMap;
  dynamic itemResponseList;

  SingleOfferInfoModel({
    this.id,
    this.offerName,
    this.offerCode,
    this.description,
    this.image,
    this.price,
    this.tax,
    this.priceWithTax,
    this.inStock,
    this.recipeMap,
    this.itemResponseList,
  });

  factory SingleOfferInfoModel.fromJson(Map<String, dynamic> json) {
    return SingleOfferInfoModel(
      id: json['id'] as int?,
      offerName: json['offerName'] as String?,
      offerCode: json['offerCode'] as String?,
      description: json['descripation'] as String?,
      // Corrected the field name
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      tax: json['tax'] as double?,
      priceWithTax: (json['priceWithTax'] as num?)?.toDouble(),
      inStock: json['inStock'] as bool?,
      recipeMap: json['recipeMap'],
      itemResponseList: json['itemResponseList'],
    );
  }
}
