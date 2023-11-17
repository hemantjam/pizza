import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';

import '../../api/api_response.dart';
import 'menu_model.dart';

class MenuRepository {
  ApiServices apiClient = ApiServices();
  List<MenuListModel> menuList = [];

  Future<List<MenuListModel>> getMenu() async {
    ApiResponse? res = await apiClient.getRequest(ApiEndPoints.getMenu);
    if (res!=null&&res.status) {
      List<dynamic> data = res.data as List<dynamic>;

      menuList = data.map((item) => MenuListModel.fromJson(item)).toList();
    }
    /*menuList.removeWhere((item) =>
        item.name!.contains("OFFER") ||
        item.name!.contains("Build") ||
        item.name!.contains("Additional"));*/
    return menuList;
  }
}
