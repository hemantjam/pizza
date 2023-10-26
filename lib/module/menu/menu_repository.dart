import 'package:pizza/api/api_client.dart';
import 'package:pizza/api/end_point.dart';

import '../../api/api_response.dart';
import 'menu_model.dart';

class MenuRepository {
  ApiClient apiClient = ApiClient();
  List<MenuListModel> menuList = [];

  Future<List<MenuListModel>> getMenu() async {
    ApiResponse? res = await apiClient.getRequest(ApiEndPoints.getMenu);

    List<dynamic> data = res!.data as List<dynamic>;

    menuList = data.map((item) => MenuListModel.fromJson(item)).toList();
    menuList.removeWhere((item) =>
        item.name!.contains("OFFER") ||
        item.name!.contains("Build") ||
        item.name!.contains("Additional"));
    return menuList;
    // notifyListeners();
  }
}
