import 'package:flutter/material.dart';
import 'package:pizza/constants/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  handleNavigation() {
    Future.delayed(
        Duration.zero, () => Navigator.pushNamed(context, RouteNames.homePage));
  }

  @override
  void initState() {
    super.initState();
    handleNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
