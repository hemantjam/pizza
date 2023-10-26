import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OffersItem extends StatefulWidget {
  const OffersItem({super.key});

  @override
  State<OffersItem> createState() => _OffersItemState();
}

class _OffersItemState extends State<OffersItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("OFFERS"),
              Text("View All"),
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: Stack(
            children: [
              Card(
                child: SizedBox(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(offer, fit: BoxFit.contain),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("OFFER 1"),
                            Text(r'34$'),
                          ],
                        ),
                      ),
                      const Text(
                          "description in form of long text as wellllllllllllll")
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CupertinoButton(
                    onPressed: () {},
                    color: Colors.orange,
                    child: const Text("order now"),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

String offer =
    "https://apis.pineapplepizza.com.au/POSLocalAPI/uploads/images/ahaTc_offer1.jpg";
