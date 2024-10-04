
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
   final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kHanoi = CameraPosition(
  // bearing: 192.8334901395799,
  target: LatLng(21.028511, 105.804817), // Tọa độ Hà Nội
  // tilt: 59.440717697143555,
  zoom: 14.4746
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: 200),
            mapType: MapType.normal,
            initialCameraPosition: _kHanoi ,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10,)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width -70,
                    child: ElevatedButton.icon(onPressed: (){

                    },icon: Icon(CupertinoIcons.shopping_cart) ,label: Text('Mua ngay',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,)),),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}