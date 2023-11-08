import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderMap extends StatelessWidget {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final LatLng position = const LatLng(-37.74406743182319, 144.89112969639197);

  OrderMap({super.key});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: {
        Marker(
          markerId: const MarkerId("Pippo's pizza"),
          position: position,
        )
      },
      mapType: MapType.hybrid,
      initialCameraPosition:
          CameraPosition(target: position, zoom: 19.151926040649414),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
