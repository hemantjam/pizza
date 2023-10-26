
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/api.dart';
import '../../api/api_response.dart';
import 'menu_model.dart';

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  ApiClient apiClient = ApiClient();
  List<MenuListModel> menuListModel = [];

  getMenu() async {
    ApiResponse? res = await apiClient.getRequest("homeController/menus/");
    List<dynamic> data = res!.data as List<dynamic>;
    menuListModel = data.map((item) => MenuListModel.fromJson(item)).toList();
    menuListModel.removeWhere((item) =>
        item.name!.contains("OFFER") ||
        item.name!.contains("Build") ||
        item.name!.contains("Additional"));
    setState(() {});
  }

  @override
  void initState() {
    getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10.0,
        runSpacing: 10.0,
        children: menuListModel.map((e) => menuItem(e)).toList(),
      ),
    );
  }

  Card menuItem(MenuListModel item) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          item.bigImage != null
              ? SvgPicture.network(
                  item.bigImage ?? "",
                  fit: BoxFit.contain,
                  height: 100,
                )
              : const SizedBox(),
          Text(item.name ?? ""),
        ],
      ),
    );
  }
}
