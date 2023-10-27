import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pizza/module/menu/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../api/api_services.dart';
import '../../api/api_response.dart';
import 'menu_model.dart';

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {

  @override
  void initState() {
    super.initState();
    Provider.of<MenuProvider>(context,listen: false).getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context,MenuProvider provider, child) {
        return Card(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 10.0,
            children: provider.menuListModel.map((e) => menuItem(e)).toList(),
          ),
        );
      },
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
