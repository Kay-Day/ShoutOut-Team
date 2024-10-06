
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoutout_shop_app/views/screens/home_screen.dart';
import 'package:shoutout_shop_app/views/screens/main_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
   final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

     late GoogleMapController mapController;

  static const CameraPosition _kHanoi = CameraPosition(
  // bearing: 192.8334901395799,
  target: LatLng(21.028511, 105.804817), // Tọa độ Hà Nội
  // tilt: 59.440717697143555,
  zoom: 14.4746
);

late Position currentPosition;

getUserCurrentLocation()async{
  await Geolocator.checkPermission();

  await Geolocator.requestPermission();

  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation, forceAndroidLocationManager: true);

  currentPosition = position;

  LatLng pos = LatLng(position.latitude, position.longitude);
  CameraPosition cameraPosition = CameraPosition(target: pos, zoom: 16);
  mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            padding: EdgeInsets.only(bottom: 200),
            mapType: MapType.normal,
            initialCameraPosition: _kHanoi ,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);

              mapController = controller;

              getUserCurrentLocation();
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
                      Get.offAll(MainScreen());

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