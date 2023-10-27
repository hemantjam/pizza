import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:provider/provider.dart';

import '../initial_services/login_by_ip/login_by_ip_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void handleNavigation() {
    Provider.of<LoginByIpProvider>(context, listen: false).loginByIp();
  /*  Future.delayed(Duration(seconds: 1),
        () => Navigator.pushNamed(context, RouteNames.homePage));*/
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      handleNavigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginByIpProvider>(
        builder: (context, provider, child) {
          return provider.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Placeholder();
        },
      ),
    );
  }
}
