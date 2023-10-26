/*class MenuModel {
  String? message;
  bool? status;
  List<MenuListModel>? data;

  MenuModel({
    this.message,
    this.status,
    this.data,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    var data = json['data'] as List;
    List<MenuListModel> dataItems =
        data.map((item) => MenuListModel.fromJson(item)).toList();

    return MenuModel(
      message: json['message'],
      status: json['status'],
      data: dataItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}*/

class MenuListModel {
  int? id;
  int? sortOrder;
  String? name;
  String? code;
  String? smallImage;
  String? bigImage;
  bool? webDisplay;

  MenuListModel({
    this.id,
    this.sortOrder,
    this.name,
    this.code,
    this.smallImage,
    this.bigImage,
    this.webDisplay,
  });

  factory MenuListModel.fromJson(Map<String, dynamic> json) {
    return MenuListModel(
      id: json['id'],
      sortOrder: json['sortOrder'],
      name: json['name'],
      code: json['code'],
      smallImage: json['smallImage'],
      bigImage: json['bigImage'],
      webDisplay: json['webDisplay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sortOrder': sortOrder,
      'name': name,
      'code': code,
      'smallImage': smallImage,
      'bigImage': bigImage,
      'webDisplay': webDisplay,
    };
  }
}
