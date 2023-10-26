import 'package:flutter/material.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/home/home_provider.dart';
import 'package:provider/provider.dart';

import '../menu/menu.dart';
import '../offers/offers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            primary: true,
            child: Consumer<HomeProvider>(
              builder: (context, HomeProvider provider, child) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: provider.toggleHeaderOptions,
                          child: Container(
                            width: 40, // Set the desired width
                            height: 40, // Set the desired height
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Circular shape
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 3.0, // Border width
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.list,
                                color: Colors.black // Icon color
                                ,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_shopping_cart)),
                      ],
                    ),
                    Visibility(
                        visible: provider.showHeader,
                        child: const HeaderOptions()),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      height: 30,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Banner(),
                    const Menus(),
                    const OffersItem(),
                    const OffersItem()
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Image.network(
            "https://tomcat.harvices.com/pizza_portal_v2_demo/static/media/banner.7c1966eb.jpg",
            fit: BoxFit.cover,
            height: 100,
          ),
          const DeliveryOptions()
        ],
      ),
    );
  }
}

class DeliveryOptions extends StatelessWidget {
  const DeliveryOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.local_shipping, color: Colors.orange),
                      SizedBox(width: 8.0),
                      Text(
                        "Order Delivery",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              color: Colors.black,
              width: 2,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // Background color for Order Pick-up
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.shopping_bag, color: Colors.brown),
                      // Bag icon
                      SizedBox(width: 8.0),
                      Text(
                        "Order Pick-up",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderOptions extends StatelessWidget {
  const HeaderOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("HOME"),
        const Text("MENU"),
        const Text("OFFERS"),
        const Text("CONTACT US"),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.login);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sign-In"),
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
